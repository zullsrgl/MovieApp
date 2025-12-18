//
//  PlayerLayerView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 18.12.2025.
//

import SwiftUI
import AVFoundation

final class VideoPlayerView: UIView {
    override class var layerClass: AnyClass {
        AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }

    var player: AVPlayer? {
        get {
            playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
}

struct PlayerLayerView: UIViewRepresentable {
    var player: AVPlayer

    func makeUIView(context: Context) -> VideoPlayerView {
        let view = VideoPlayerView()
        view.playerLayer.videoGravity = .resizeAspect
        view.player = player
        return view
    }

    func updateUIView(_ uiView: VideoPlayerView, context: Context) {
        uiView.player = player
    }
}
