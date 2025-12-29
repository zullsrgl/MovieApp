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
    @State private var selectedRateIndex = 2
    @State private var isPlaying: Bool = false
    @State private var currentTime: Double = 0.0
    @State private var totalTime: Double =  1
    @State private var timeObserver: Any?
    @State private var statusObservation: NSKeyValueObservation?
    @StateObject private var viewModel = PlayerViewModel()
    
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
            Color("black")
                .opacity(showControls ? 0.45 : 0)
                .ignoresSafeArea()
                .animation(.easeInOut, value: showControls)
                .allowsHitTesting(false)
            
            if showControls {
                VStack{
                    Spacer()
                    HStack(spacing: 100) {
                        CustomPlayerButton(systemName: "gobackward.10") {
                            seek(by: -10)
                        }
                        CustomPlayerButton(systemName: isPlaying ? "pause.fill" : "play.fill") {
                            isPlaying ? player.pause() : player.play()
                            isPlaying.toggle()
                            
                        }
                        CustomPlayerButton(systemName: "goforward.10") {
                            seek(by: 10)
                        }
                    }
                    
                    Spacer()
                    
                    ProgressBarView(
                        totalTime: totalTime,
                        currentTime: currentTime,
                        onSeek: { seconds in
                            let time = CMTime(seconds: seconds, preferredTimescale: 600)
                            player.seek(to: time)
                        },
                        subtitles: viewModel.subtitleOptions,
                        
                        selecedSubTitle: { option in
                            selectSubtitle(option: option)
                        },
                        speedIndexSelected: { index in
                            player.rate = index
                        },
                        rateIndex: $selectedRateIndex
                    )
                }
            }
        }
        .onAppear{
            enterVideoMode()
            player.play()
            isPlaying = true
            avPlayerDuration()
            avPlayerCurrentTime()
            
            Task {
                await viewModel.loadSubtitles(player: player)
            }
            
        }
        .onDisappear{
            exitVideoMode()
            player.pause()
            isPlaying = false
            if let observer = timeObserver {
                player.removeTimeObserver(observer)
            }
        }
        .navigationBarBackButtonHidden(!showControls)
    }
    
    private func selectSubtitle(option: AVMediaSelectionOption?){
        guard let currentItem = player.currentItem,
              let group = currentItem.asset
            .mediaSelectionGroup(forMediaCharacteristic: .legible) else { return }
        if let option {
            currentItem.select(option, in: group)
        } else {
            currentItem.select(nil, in: group)
        }
    }
    
    private func avPlayerDuration() {
        if let duration = player.currentItem?.duration, duration.isNumeric{
            totalTime = duration.seconds
        }else {
            statusObservation = player.currentItem?.observe(\AVPlayerItem.status, options: [.initial, .new]) { item, _ in
                if item.status == .readyToPlay,
                   item.duration.isNumeric {
                    totalTime = item.duration.seconds
                }
            }
        }
    }
    
    private func avPlayerCurrentTime() {
        let interval = CMTime(seconds: 1, preferredTimescale: 600)
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            self.currentTime = time.seconds
            
        }
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
