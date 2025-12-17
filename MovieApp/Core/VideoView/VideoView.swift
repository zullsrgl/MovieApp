//
//  VideoView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 16.12.2025.
//

import SwiftUI
import AVKit

struct VideoView: View {

    private let player = AVPlayer(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!)
 
    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear {
                enterVideoMode()
                player.play()
            }
            .onDisappear {
                exitVideoMode()
                player.pause()
            }
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
    VideoView()
}
