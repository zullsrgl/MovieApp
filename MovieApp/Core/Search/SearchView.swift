//
//  SearchView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 17.12.2025.
//

import SwiftUI

struct SearchView: View {
    let onClickedPlay: () -> Void
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                SearchCellView(movies: viewModel.movies, onWatchClicked: {
                    onClickedPlay()
                }
                )
            }
            .padding()
        }
        .background(Color("black"))
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.automatic)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search Movies"
        )
        .onChange(of: searchText) {
            if searchText.count > 2 {
                viewModel.searchMoviesFetched(searchText: searchText)
            } else if searchText.isEmpty {
                viewModel.fecthTopMovies()
            }
        }
        .onAppear {
            viewModel.fecthTopMovies()
        }
    }
}

#Preview {
    SearchView(onClickedPlay: {})
}
