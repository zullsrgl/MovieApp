//
//  WatchButtons.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct WatchButtons: View {
    var body: some View {
        
        ZStack(alignment: .leading) {
            Color("black")
                .ignoresSafeArea()
            HStack(spacing: 8){
                
                Button {
                    //TODO: Watch buton actions
                    
                }label: {
                    Text("Watch")
                        .padding()
                        .foregroundColor(Color("black"))
                        .frame(width: 150, height: 40)
                        .overlay(
                              RoundedRectangle(cornerRadius: 20)
                                  .stroke(Color.white, lineWidth: 2)
                          )
                        .background(Color("primary"))
                        .cornerRadius(20)
                    
                }
                
                Button {
                    //TODO: Trailler buton actions
                    
                } label: {
                    Text("Trailler")
                        .padding()
                        .foregroundColor(Color("white"))
                        .frame(width: 150, height: 40)
                        .overlay(
                              RoundedRectangle(cornerRadius: 20)
                                  .stroke(Color.white, lineWidth: 2)
                          )
                        .background(Color("secondary"))
                        .cornerRadius(20)
                }
            }
        }
        .padding(.leading, 16)
    }
}

#Preview {
    WatchButtons()
}
