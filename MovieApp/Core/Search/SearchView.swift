//
//  SearchView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 17.12.2025.
//

import SwiftUI

struct SearchView: View {
    
    let onClickedPlay: () -> Void
    @StateObject var viewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var searchTask: Task<Void, Never>?
    
    var body: some View {
        ScrollView {
            SearchCellView(movies: viewModel.movies, onWatchClicked: {
                onClickedPlay()
            })
            .padding()
        }
        .background(Color("black"))
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.large)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search Movies"
        )
        .onChange(of: searchText) { oldValue, newValue in
            searchTask?.cancel()

            searchTask = Task {
                try? await Task.sleep(nanoseconds: 600_000_000)

                guard !Task.isCancelled else { return }

                if newValue.count > 2 {
                    await viewModel.searchMoviesFetched(searchtext: newValue)
                } else if newValue.isEmpty {
                    await viewModel.fetchTopMovies()
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchTopMovies()
            }
        }
    }
}

#Preview {
    SearchView(onClickedPlay: {})
}

