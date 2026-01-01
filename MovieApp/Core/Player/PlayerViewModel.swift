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
    @Published var resolutions: [(String, Double)] = []
    
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
    
    func fetchAvailableResolutions(player: AVPlayer) async {
        guard let urlAsset = player.currentItem?.asset as? AVURLAsset else { return }
        
        do {
            let variants = try await urlAsset.load(.variants)
            
            let fetchedRes: [(String, Double)] = variants.compactMap { variant -> (String, Double)? in
                let height = variant.videoAttributes?.presentationSize.height ?? 0
                let bitrate = variant.averageBitRate ?? 0 > 0 ? variant.averageBitRate : variant.peakBitRate
                guard height > 0 else { return nil }
                return ("\(Int(height))p", bitrate) as? (String, Double)
           
            }
            
            await MainActor.run {
                let uniqueRes = Dictionary(grouping: fetchedRes, by: { $0.0 })
                    .compactMap { $0.value.first }
                    .sorted(by: { $0.1 > $1.1 })
                
                self.resolutions = uniqueRes
                self.resolutions.insert(("Automatic", 0.0), at: 0)
                
            }
        } catch {
            print("\(error.localizedDescription)")
        }
    }
}
