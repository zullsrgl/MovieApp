//
//  CategoryView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct CategoryView: View {
    
    let categoryName: String
    let movies: [Movie]
    let onItemCliked: (Int) ->Void
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(categoryName)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color("white"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing:10){
                    
                    ForEach(movies) { movie in
                        
                        if let originalTitle = movie.originalTitle,
                           let posterPath = movie.posterPath {
                            
                            MovieView(
                                movieName: originalTitle,
                                posterPath: posterPath
                            )
                            .onTapGesture {
                                if let id = movie.id {
                                    onItemCliked(id)
                                }
                                
                            }
                        }
                    }
                }
                .padding(.horizontal, 12)
                .scrollTargetLayout()
            }
            
        }
    }
}

#Preview {
    CategoryView(categoryName: "Komedi", movies: [], onItemCliked: {id in})
}

struct MovieView: View {
    var movieName: String
    var posterPath: String
    
    var body: some View {
        VStack(spacing: 0) {
            
            AsyncImage(
                url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            ) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 150, height: 200)
            .clipped()
            
            Text(movieName)
                .font(.title3)
                .foregroundColor(Color("white"))
                .frame(maxWidth: 150, minHeight: 32)
                .background(
                    RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .fill(Color("darkGray"))
                        .background(.ultraThinMaterial)
                )
        }
        .cornerRadius(16)
    }
}
