//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 14.12.2025.
//

import Foundation


class MovieService {
    
    static let shared = MovieService()
    
    private let baseUrl: String = "https://api.themoviedb.org/3"
    private let apiKey: String = "7e453b0f72f2441f91fecf6a5e810ebc"
    
    func fetchMovies() async throws -> [Movie] {
        let urlString = "\(baseUrl)/movie/popular?api_key=\(apiKey)&language=tr-TR"
        guard let url = URL(string: urlString)  else { throw URLError(.badURL)}
        let (data, _) = try await URLSession.shared.data(from: url)
        let moviesResult =  try JSONDecoder().decode(MovieResponse.self, from: data)
        return moviesResult.results ?? []
    }
    
    func fethMoviesByGenre(genre: MovieGenreType) async throws -> [Movie] {
        let urlString = "\(baseUrl)/discover/movie?api_key=\(apiKey)&language=tr-TR&with_genres=\(genre.rawValue)&sort_by=popularity.desc"
        guard let url = URL(string: urlString) else { throw URLError(.badURL)}
        let (data, _) = try await URLSession.shared.data(from: url)
        let moviesResult =  try JSONDecoder().decode(MovieResponse.self, from: data)
        return moviesResult.results ?? []
    }
    
    func fetchMovieDetails(movieId: Int) async throws -> Movie {
        let urlString = "\(baseUrl)/movie/\(movieId)?api_key=\(apiKey)&language=tr-TR"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Movie.self, from: data)
    }
    
    func searchMovies(query: String) async throws -> [Movie] {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string:"\(baseUrl)/search/movie?api_key=\(apiKey)&language=tr-TR&query=\(encodedQuery)")
        else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let moviesResult = try JSONDecoder().decode(MovieResponse.self , from: data)
        return moviesResult.results ?? []
    }
    
    func fetchSubtitleLanguages(url: String) async throws -> [String] {
        guard let url = URL(string: url) else { return [] }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard let content = String(data: data, encoding: .utf8) else { return [] }

        let lines = content.components(separatedBy: "\n")
        let subtitleLines = lines.filter { $0.starts(with: "#EXT-X-MEDIA:TYPE=SUBTITLES") }

        var languages: Set<String> = []

        for line in subtitleLines {
            if let langPart = line.split(separator: ",").first(where: { $0.contains("URI=") }) {
                
                let uri = langPart.replacingOccurrences(of: "URI=", with: "").replacingOccurrences(of: "\"", with: "")
                if let match = uri.split(separator: "_").first(where: { $0.contains("fr") || $0.contains("en") || $0.contains("cmn") }) {
                    let code = String(match)
                    languages.insert(code)
                }
            }
        }
        return Array(languages) 
    }
}
