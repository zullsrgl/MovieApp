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
        Task {
            await fetchTopMovies()
            await fetchGenres()
        }
    }
    
    @MainActor
    private func fetchTopMovies() async {
        do {
            self.movies = try await MovieService.shared.fetchMovies()
        }catch {
            print("search view model error")
        }
    }
    
    @MainActor
    private func fetchGenres() async {
        do {
            let genres = MovieGenreType.allCases.shuffled().prefix(10)
            
            for genre in genres {
                let movies = try await MovieService.shared.fethMoviesByGenre(genre: genre)
                genreMovies[genre] = movies
            }
            
        } catch {
            print("genre fetch error:", error)
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
