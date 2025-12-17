//
//  DetailView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct DetailView: View {
    
    let movieId: Int
    let onWatchClicked: () -> Void
    @StateObject private var viewModel = DetailViewModel()
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    if let movie = viewModel.movie {
                        MovieDetailHeaderView(movie: movie)
                        Spacer()
                        WatchButtons(onWatchClicked: {
                            onWatchClicked()
                        })
                            .padding(.leading)
                        Spacer()
                        if let overview = movie.overview {
                            MovieInformation(text: overview)
                        }
                    }
                }
            }
            .background(Color("black"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear{
            viewModel.fetchMovieDetail(id: movieId)
        }
    }
}

#Preview {
    DetailView(movieId: 2, onWatchClicked: {})
}
