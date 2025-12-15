//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 14.12.2025.
//

import Foundation

final class HomeViewModel: ObservableObject{
    
    @Published var movies: [Movie] = []
    @Published var genreMovies: [MovieGenreType: [Movie]] = [:]
    
    func fetchHomeData() {
        fetchPopulerMovie()
        fetchGenres()
    }
    
    
    private func fetchPopulerMovie() {
        MovieService.shared.fetchMovies { [weak self] movies in
            self?.movies = movies
        }
    }
    
    
    private func fetchGenres(){
        let genres = MovieGenreType.allCases.shuffled().prefix(10)
        
        genres.forEach { genre in
            MovieService.shared.fethMoviesByGenre(genre: genre) { [weak self] result in
            
                if case .success(let movies) = result {
                    self?.genreMovies[genre] = movies
                }
            }
        }
    }
}
