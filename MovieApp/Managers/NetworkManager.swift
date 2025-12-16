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
    
    func fetchMovies(completion: @escaping ([Movie]) -> Void) {
        
        let urlString = "\(baseUrl)/movie/popular?api_key=\(apiKey)&language=tr-TR"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            do {
                let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(decodedResponse.results)
                }
                
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    
    func fethMoviesByGenre(genre: MovieGenreType, completion: @escaping(Result<[Movie], Error>) -> Void){
        
        let urlString = "\(baseUrl)/discover/movie?api_key=\(apiKey)&language=tr-TR&with_genres=\(genre.rawValue)&sort_by=popularity.desc"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url){ data, _ , error in
            
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else { return }
            
            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(response.results))
                }
                
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
    func fetchMovieDetails(movieId: Int, completion: @escaping(Result<Movie, Error>) -> Void){
        
        let urlString = "\(baseUrl)/movie/\(movieId)?api_key=\(apiKey)&language=tr-TR"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url){ data, _ , error in
            
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else { return }
            
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(movie))
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
