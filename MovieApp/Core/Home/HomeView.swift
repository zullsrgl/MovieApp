//
//  HomeView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    HeaderView(movies: viewModel.movies)
                        .padding()
                    
                    ForEach(Array(viewModel.genreMovies.keys), id: \.self) { genre in
                        CategoryView(
                            categoryName: genre.title,
                            movies: viewModel.genreMovies[genre] ?? []
                        )
                        .padding()
                    }
                }
                .padding(.bottom, 20)
            }
            .background(Color("black"))
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color("black").opacity(0.5), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
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
                        
                    }label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                    }
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
