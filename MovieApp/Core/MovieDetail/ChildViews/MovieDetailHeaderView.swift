//
//  MovieDetailHeaderView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct MovieDetailHeaderView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("avatar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(
                    LinearGradient(colors:[
                        Color("black").opacity(0),
                        Color("black").opacity(1),], startPoint: .center, endPoint: .bottom)
                )
                .clipped()
            
            VStack {
                Image("avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.5), Color.white.opacity(0.1)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                lineWidth: 4
                            )
                    )
                    .clipped()
                
                Text("Avatar")
                    .font(.title2)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("primary"))
                    
                    Text("4.3")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.white)
                    
                    Text("2024")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
            }
            .padding()
        }
    }
}

#Preview {
    MovieDetailHeaderView()
}
