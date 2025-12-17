//
//  MovieCellView.swift
//  MovieApp
//
//  Created by Enes Arabacı on 17.12.2025.
//

import SwiftUI

struct SearchCellView: View {
    
    let movies: [Movie]
    let onWatchClicked: () -> Void
    
    var body: some View {
        
        ScrollView {
            LazyVStack(spacing: 40) {
                ForEach(movies) { movie in
                    HStack {
                        
                        if let posterPath = movie.posterPath {
                            
                        
                        
                        AsyncImage(
                            url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                        ) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 200)
                                .cornerRadius(25)
                                .clipped()
                            
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .padding(.horizontal)
                        }
                        
                        if let title = movie.title {
                            Text(title)
                            .font(.title2)
                            
                            .fontWeight(.semibold)
                            .foregroundColor(Color("white"))
                        }
                        Spacer()
                        Image(systemName: "play.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color("white").opacity(0.8))
                            .clipped()
                        
                            .onTapGesture {
                                onWatchClicked()
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .padding()
        
    }
}

#Preview {
    SearchCellView(movies: [], onWatchClicked: {})
}
