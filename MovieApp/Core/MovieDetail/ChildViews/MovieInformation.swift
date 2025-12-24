//
//  MovieInformation.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct MovieInformation: View {
    
    let text: String
    @State private var expanded = false
    let lineLimit: Int = 3
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text(text)
                .foregroundColor(Color("white"))
                .font(.subheadline)
                .lineLimit(expanded ? nil : lineLimit)
                .padding(.horizontal)
            
            if !expanded{
                Button("Read More"){
                    expanded = true
                }
                .padding(.horizontal)
            }else {
                Button("Less"){
                    expanded = false
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    MovieInformation(text: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal")
}
