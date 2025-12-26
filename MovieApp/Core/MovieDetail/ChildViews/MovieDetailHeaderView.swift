//
//  MovieDetailHeaderView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct MovieDetailHeaderView: View {
    let movie: Movie
    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            if let posterPath = movie.posterPath {
                AsyncImage(
                    url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(
                            LinearGradient(
                                colors: [
                                    Color("black").opacity(0),
                                    Color("black").opacity(1)
                                ],
                                startPoint: .center,
                                endPoint: .bottom
                            )
                        )
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                
            }
            
            VStack(alignment: .leading) {
                if let posterPath = movie.posterPath {
                    AsyncImage(
                        url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                        
                    ) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        LinearGradient(
                                            colors: [Color.white.opacity(0.5), Color.white.opacity(0.1)],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        ),
                                        lineWidth: 4
                                    )
                            )
                            .clipped()
                        
                    } placeholder: {
                        Color.gray.opacity(0.3)
                        
                    }
                }
                if let title = movie.title {
                    Text(title)
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                
                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("primary"))
                    
                    if let voteAverage = movie.voteAverage {
                        Text("\(voteAverage)")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Circle()
                            .frame(width: 6, height: 6)
                            .foregroundColor(.white)
                    }
                    
                    if let releaseDate = movie.releaseDate {
                        Text(releaseDate)
                            .font(.footnote)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    MovieDetailHeaderView(movie: Movie(id: 2, title: "", originalTitle: "", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/dys7EksOQd1ej4jWmi503kEmSBP.jpg", backdropPath: "", releaseDate: "", voteAverage: 12.7, voteCount: 2, genreIds: []))
}
