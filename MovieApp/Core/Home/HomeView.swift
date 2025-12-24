//
//  HomeView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

enum Route: Hashable {
    case home
    case detail(movieId: Int)
    case player
    case search
}

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVStack {
                    HeaderView(movies: viewModel.movies,
                               onWatchCliked: {
                        path.append(Route.player)
                    },
                               onDetailCliked: { movieId in
                        path.append(Route.detail(movieId: movieId))
                    })
                    .padding()
                    
                    ForEach(Array(viewModel.genreMovies.keys), id: \.self) { genre in
                        CategoryView(
                            categoryName: genre.title,
                            movies: viewModel.genreMovies[genre] ?? [],
                            onItemCliked: { movieId in
                                
                                path.append(Route.detail(movieId: movieId))
                            })
                        
                        .padding()
                    }
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        
                    }label: {
                        Image(systemName: "airplayvideo")
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        path.append(Route.search)
                    }label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("white"))
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home: HomeView()
                case .detail(let movieId): DetailView(movieId: movieId, onWatchClicked: {
                    path.append(Route.player)
                    
                })
                case .player: PlayerView()
                case .search: SearchView(onClickedPlay:{
                    path.append(Route.player)
                })
                    
                }
            }
        }
        .onAppear{
            viewModel.fetchHomeData()
        }
    }
}

#Preview {
    HomeView()
}
