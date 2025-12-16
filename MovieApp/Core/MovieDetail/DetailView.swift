//
//  DetailView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct DetailView: View {
    
    var movieId: Int
    @StateObject private var viewModel = DetailViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    if let movie = viewModel.movie {
                        MovieDetailHeaderView(movie: movie)
                        Spacer()
                        WatchButtons()
                            .padding(.leading)
                        Spacer()
                        MovieInformation(text: movie.overview ?? "")
                    }
                }
            }
            .background(Color("black"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }.onAppear{
            viewModel.fetchMovieDetail(id: movieId)
        }
    }
}

#Preview {
    DetailView(movieId: 1)
}
