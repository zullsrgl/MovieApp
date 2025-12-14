//
//  HeaderView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct HeaderView: View {
    
    var movies: [Movie]
    
    var body: some View {
        
        TabView {
            ForEach(movies) { movie in
                
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.black.opacity(0.9))
                        .shadow(
                            color: Color.black.opacity(0.5),
                            radius: 12,
                            y: 8
                        )
                    
                    ZStack(alignment: .leading) {
                        
                        AsyncImage(
                            url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
                        ) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(height: 420)
                        .clipped()
                        
                        LinearGradient(
                            colors: [
                                Color.black.opacity(0.0),
                                Color.black.opacity(0.7)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text(movie.title)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Text(movie.overview ?? "")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .lineLimit(2)
                            
                            HStack(spacing: 12) {
                                Button { } label: {
                                    Label("Watch", systemImage: "play.fill")
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 10)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                }
                                
                                Button { } label: {
                                    Image(systemName: "plus")
                                        .foregroundColor(.black)
                                        .padding(12)
                                        .background(Color.white.opacity(0.5))
                                        .cornerRadius(12)
                                }
                            }
                        }
                        .padding(.top, 200)
                        .padding(.bottom, 40)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 28))
                }
                .padding(.horizontal, 24)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: 450)
    }
}

#Preview {
    HeaderView(movies: [])
}
