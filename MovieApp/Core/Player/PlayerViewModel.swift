//
//  PlayerViewModel.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 25.12.2025.
//

import SwiftUI

@MainActor
final class PlayerViewModel: ObservableObject {
    
    @Published var subtitleLanguages: [String] = []
  
    func fetchSubTitles(url : String) async {
        do {
            subtitleLanguages =  try await MovieService.shared.fetchSubtitleLanguages(url: url)
        }catch {
            print("player viewModel error")
        }
        
    }
}
