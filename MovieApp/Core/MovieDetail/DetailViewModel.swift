//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 16.12.2025.
//

import Foundation

final class DetailViewModel: ObservableObject{
    @Published var movie: Movie?
    
    func fetchMovieDetail(id: Int) {
        MovieService.shared.fetchMovieDetails(movieId: id) { result in
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                print("detail view model error: \(error)")
            }
        }
    }
}
