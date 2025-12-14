//
//  DetailView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    MovieDetailHeaderView()
                    Spacer()
                    WatchButtons()
                        .padding(.leading)
                    Spacer()
                    MovieInformation(text: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layoutIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layoutIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout")
                }
            }
            .background(Color("black"))
            .navigationTitle("Movie Name")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.clear, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview {
    DetailView()
}
