//
//  HeaderView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct HeaderView: View {
    let movies: [Movie]
    let onWatchCliked: () ->Void
    let onDetailCliked: (Int) ->Void
    
    var body: some View {
        TabView {
            ForEach(movies) { movie in
                
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.black.opacity(0.9))
                    
                    ZStack(alignment: .leading) {
                        
                        if let posterPath = movie.posterPath {
                            AsyncImage(
                                url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                            ) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 420)
                                    .clipped()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            if let originalTitle = movie.title,
                               let overview = movie.overview{
                                
                                
                                
                                Text(originalTitle)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                
                                Text(overview)
                                    .font(.footnote)
                                    .font(.system(size: 24))
                                    .lineLimit(3)
                                    .foregroundColor(Color("white"))
                                
                            }
                            HStack(spacing: 12) {
                                
                                Button {
                                    onWatchCliked()
                                }
                                label: {
                                    Label("Watch", systemImage: "play.fill")
                                        .foregroundColor(Color("black"))
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 10)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                }
                                
                                Button {
                                    if let id = movie.id {
                                        onDetailCliked(id)
                                    }
                                    
                                } label: {
                                    Label("", systemImage: "arrowshape.right.fill")
                                        .foregroundColor(Color("black"))
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 10)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                        .padding(.top, 200)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 28))
                }
                .padding()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: 450)
    }
    
}

#Preview {
    HeaderView(movies: [], onWatchCliked: {}, onDetailCliked: {_ in })
}
