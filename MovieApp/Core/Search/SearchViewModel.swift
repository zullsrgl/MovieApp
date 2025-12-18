//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 17.12.2025.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    
    func fecthTopMovies() {
        
        MovieService.shared.fetchMovies { [weak self] movies in
            self?.movies = movies
        }
    }
    
    func searchMoviesFetched(searchText: String) {
        MovieService.shared.searchMovies(query: searchText){ [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                
            case .failure(let error):
                print("search viewmodel error:\(error) ")
            }
            
        }
    }
}
