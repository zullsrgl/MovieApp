//
//  CostumeVideoPlayer.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 18.12.2025.
//

import SwiftUI

struct CustomPlayerButton: View {
    
    let systemName: String
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action){
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(Color("white").opacity(0.7))
        }
        
    }
}

#Preview {
    CustomPlayerButton(systemName: "goforward.10", action: {})
}
