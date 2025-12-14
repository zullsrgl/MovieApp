//
//  HomeView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI
struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    HeaderView()
                        .padding()
                    
                    CategoryView(categoryName: "Dram")
                        .padding(.bottom, 20)
                    CategoryView(categoryName: "Komedi")
                        .padding(.bottom, 20)
                    CategoryView(categoryName: "Gişe Rekoru Kıranlar")
                        .padding(.bottom, 20)
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
    }
}

#Preview {
    HomeView()
}
