//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 14.12.2025.
//

import Foundation

final class HomeViewModel: ObservableObject{
    
    @Published var movies: [Movie] = []
    
    func fetchPopulerMovie() {
        MovieService.shared.fetchMovies { [weak self] movies in
            self?.movies = movies
        }
    }
    
}
