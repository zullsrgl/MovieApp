//
//  VideoView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 16.12.2025.
//

import SwiftUI
import AVKit

struct VideoView: View {
    var player: AVPlayer! {
        AVPlayer(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!)
        
    }
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .ignoresSafeArea()
            
                .onAppear{
                    enterVideoMode()
                }
                .onDisappear {
                    exitVideoMode()
                }
        }
    }
    
    
    private func enterVideoMode() {
        AppDelegate.orientationLock = .landscape
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
        player.play()
    }
    
    private func exitVideoMode() {
        AppDelegate.orientationLock = .portrait
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
        player.pause()
    }
}

#Preview {
    VideoView()
}
