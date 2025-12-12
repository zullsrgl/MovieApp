//
//  CategoryView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct CategoryView: View {
    
    var categoryName: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(categoryName)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color("white"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing:10){
                    
                    ForEach(1..<20, id: \.self){ movies in
                        MoviView(movieName: "Avatar")
                    }
                }
                .padding(.horizontal, 12)
                .scrollTargetLayout()
            }
            
        }
    }
}

#Preview {
    CategoryView(categoryName: "Komedi")
}
struct MoviView: View {
    var movieName: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image("avatar")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 200)
                .clipped()

            Text(movieName)
                .font(.title3)
                .foregroundColor(Color("white"))
                .frame(maxWidth: 150, minHeight: 32)
                .background(
                    RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .fill(Color("darkGray"))
                        .background(.ultraThinMaterial)
                )
        }
        .cornerRadius(16)
    }
}
