//
//  PlayerViewModel.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 25.12.2025.
//

import SwiftUI
import AVFoundation

@MainActor
final class PlayerViewModel: ObservableObject {
    
    @Published var subtitleOptions: [AVMediaSelectionOption] = []
    
    func loadSubtitles(player: AVPlayer) async {
        guard let item = player.currentItem else { return }
        do {
            let group = try await item.asset.loadMediaSelectionGroup(for: .legible)
            await MainActor.run {
                self.subtitleOptions = group?.options ?? []
            }
        }catch {
            print("Subtitle load error:", error)
        }
    }
}
