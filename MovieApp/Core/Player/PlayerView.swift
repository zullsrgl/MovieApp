//
//  VideoView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 16.12.2025.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    @State private var showControls = true
    @State var isPlaying: Bool = false
    
     private let player = AVPlayer(
        url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!
    )
    
    var body: some View {
        ZStack {
            Color("black")
                .ignoresSafeArea()
            PlayerLayerView(player: player)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        showControls.toggle()
                    }
                }
            
            if showControls {
                HStack(spacing: 100) {
                    CustomPlayerButton(systemName: "gobackward.10") { seek(by: -10) }
                    
                    CustomPlayerButton(systemName: isPlaying ? "pause.fill" : "play.fill") {
                        togglePlay()
                    }
                    
                    CustomPlayerButton(systemName: "goforward.10") { seek(by: 10) }
                }
            }
        }
        
        .onAppear {
            enterVideoMode()
            player.play()
            isPlaying = true
        }
        .onDisappear {
            exitVideoMode()
            player.pause()
        }
    }
    
    private func togglePlay(){
        if isPlaying {
            player.pause()
        }else {
            player.play()
        }
        isPlaying.toggle()
    }
    
    private func seek(by seconds: Double) {
        let currentTime = player.currentTime()
        let newSeconds = max(currentTime.seconds + seconds, 0)
        let newTime = CMTime(seconds: newSeconds, preferredTimescale: 600)
        player.seek(to: newTime)
    }
    
    private func enterVideoMode() {
        AppDelegate.orientationLock = .landscape
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue,forKey: "orientation" )
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
    private func exitVideoMode() {
        AppDelegate.orientationLock = .portrait
        UIDevice.current.setValue(  UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}
#Preview {
    PlayerView()
}
