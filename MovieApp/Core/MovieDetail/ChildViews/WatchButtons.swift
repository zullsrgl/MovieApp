//
//  WatchButtons.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 12.12.2025.
//

import SwiftUI

struct WatchButtons: View {

    let onWatchClicked: () -> Void
    var body: some View {
        HStack(spacing: 8){
            
            Button {
                onWatchClicked()
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
        }
    }
}

#Preview {
    WatchButtons(onWatchClicked: {})
}
