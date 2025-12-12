//
//  HeaderView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct HeaderView: View {
    @State private var selection = 3
    
    init(){
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("primary"))
    }
    
    let posters = [
        "poster1",
        "poster2",
        "poster3"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selection) {
                ForEach(0..<posters.count, id: \.self){ index in
                    Image("avatar")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(20)
                        .tag(index)
                        .shadow(radius: 24)
                        .overlay(
                            LinearGradient(
                                colors:[
                                    Color("black").opacity(0),
                                    Color("black").opacity(1)
                                ],
                                startPoint: .center,
                                endPoint: .bottom
                            )
                        )
                        .clipped()
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(height: 600)
        }
        .frame(maxWidth: .infinity)
        .background(Color.clear)
    }
}

#Preview {
    HeaderView()
}
