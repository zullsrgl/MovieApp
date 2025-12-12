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
                LazyVStack(spacing: 0) {
                    HeaderView()
                    
                    CategoryView(categoryName: "Dram")
                        .padding(.bottom, 20)
                    CategoryView(categoryName: "Komedi")
                        .padding(.bottom, 20)
                    CategoryView(categoryName: "Gişe Rekoru Kıranlar")
                        .padding(.bottom, 20)
                }
                .padding(.bottom, 20)
            }
            .scrollContentBackground(.hidden)
            .background(Color("black"))
            .navigationTitle("Movie App")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview {
    HomeView()
}
