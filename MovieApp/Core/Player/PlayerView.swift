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
    
    @State private var currentTime: Double = 0.0
    @State private var totalTime: Double =  1
    
    @State private var timeObserver: Any?
    @State private var statusObservation: NSKeyValueObservation?
    
    private let player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/adv_dv_atmos/main.m3u8")!)
    
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
                VStack {
                    Spacer()
                    HStack(spacing: 100) {
                        CustomPlayerButton(systemName: "gobackward.10") { seek(by: -10) }
                        
                        CustomPlayerButton(systemName: isPlaying ? "pause.fill" : "play.fill") {
                            togglePlay()
                        }
                        CustomPlayerButton(systemName: "goforward.10") { seek(by: 10) }
                    }
                    Spacer()
                    
                    VideoProgressBar(
                        totalTime: totalTime,
                        currentTime: currentTime,
                        onSeek: { seconds in
                            let time = CMTime(seconds: seconds, preferredTimescale: 600)
                            player.seek(to: time)
                        }
                    )
                }
            }
        } .onAppear {
            enterVideoMode()
            player.play()
            isPlaying = true
            
            if let duration = player.currentItem?.duration, duration.isNumeric {
                totalTime = duration.seconds
            } else {
                statusObservation = player.currentItem?.observe(\AVPlayerItem.status, options: [.initial, .new]) { item, _ in
                    if item.status == .readyToPlay, item.duration.isNumeric {
                        DispatchQueue.main.async {
                            totalTime = item.duration.seconds
                        }
                    }
                }
            }
            
            let interval = CMTime(seconds: 1, preferredTimescale: 600)
            timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak player] _ in
                guard let player = player else { return }
                currentTime = player.currentTime().seconds
            }
        }
        .onDisappear {
            exitVideoMode()
            player.pause()
            if let observer = timeObserver {
                player.removeTimeObserver(observer)
                timeObserver = nil
            }
            statusObservation?.invalidate()
            statusObservation = nil
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
