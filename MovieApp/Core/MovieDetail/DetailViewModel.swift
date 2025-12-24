//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 16.12.2025.
//

import Foundation

final class DetailViewModel: ObservableObject{
    @Published var movie: Movie?
    
    @MainActor
    func fetchMovieDetail(id: Int)  async {
        
        do {
            movie = try await MovieService.shared.fetchMovieDetails(movieId: id)
        }
        catch {
            print("search view model error")
        }
    }
}
