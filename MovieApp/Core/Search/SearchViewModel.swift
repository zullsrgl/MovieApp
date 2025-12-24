//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 17.12.2025.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    
    func fetchTopMovies() async {
        
        do {
            self.movies = try await MovieService.shared.fetchMovies()
        }catch {
            print("search view model error")
        }
    }
    
    func searchMoviesFetched(searchtext: String) async {
        do {
            movies = try await MovieService.shared.searchMovies(query: searchtext)
        } catch {
            print("search view model error")
        }
    }
}
