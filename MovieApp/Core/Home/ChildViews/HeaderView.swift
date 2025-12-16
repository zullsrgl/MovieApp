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
        
        NavigationStack {
            TabView {
                ForEach(movies) { movie in
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 28)
                            .fill(Color.black.opacity(0.9))
                        
                        ZStack(alignment: .leading) {
                            
                            AsyncImage(
                                url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
                            ) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 420)
                                    .clipped()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text(movie.title)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                
                                Text(movie.overview ?? "")
                                    .font(.footnote)
                                    .font(.system(size: 24))
                                    .lineLimit(3)
                                    .foregroundColor(Color("white"))
                               
                                
                                HStack(spacing: 12) {
                                    NavigationLink {
                                        VideoView()
                                    }
                                    label: {
                                        Label("Watch", systemImage: "play.fill")
                                            .foregroundColor(Color("black"))
                                            .padding(.horizontal, 18)
                                            .padding(.vertical, 10)
                                            .background(Color.white)
                                            .cornerRadius(12)
                                    }
                                    
                                    NavigationLink {
                                        DetailView(movieId: movie.id)
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
//                            .padding(.bottom, 40)
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
}

#Preview {
    HeaderView(movies: [])
}
