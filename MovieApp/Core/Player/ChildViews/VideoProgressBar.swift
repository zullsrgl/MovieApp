//
//  VideoProgressBar.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 18.12.2025.
//

import SwiftUI

struct VideoProgressBar: View {
    var totalTime: Double
    var currentTime: Double
    var onSeek: (Double) -> Void
    var onSpeedTap: () -> Void
    @State private var isShowingSpeedSheet = false

    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Text(formatTime(seconds: currentTime))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("white"))
                    .frame(width: 44, alignment: .leading)
                
                Slider(
                    value: Binding(
                        get: { currentTime },
                        set: { newValue in
                            onSeek(newValue)
                        }
                    ),
                    in: 0...totalTime
                )
                .tint(Color("primary"))
                
                Text("-" + formatTime(seconds: max(totalTime - currentTime, 0)))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("white"))
                    .frame(width: 44, alignment: .trailing)
            }
            
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
            .ignoresSafeArea()
        }
        
        HStack {
            Button(action: {
                withAnimation {
                        onSpeedTap()
                    }
            }){
                Image(systemName: "speedometer")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(Color("white"))
                
                    .frame(width: 32, height: 32)
                
                Text("Speed")
                    .font(.headline)
                    .foregroundStyle(Color("white"))
            }
            .padding(.horizontal, 60)
            
            Button(action: {
            }){
                Image(systemName: "text.bubble")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(Color("white"))
                
                    .frame(width: 32, height: 32)
                
                Text("Subtitle")
                    .font(.headline)
                    .foregroundStyle(Color("white"))
            }
        }
        .padding(.bottom)
    }
    
    private func formatTime(seconds: Double) -> String {
        guard seconds.isFinite else { return "00:00" }
        
        let min = Int(seconds) / 60
        let sec = Int(seconds) % 60
        return String(format: "%02d:%02d", min, sec)
    }
}

#Preview {
    VideoProgressBar(totalTime: 32.54, currentTime: 12.32, onSeek: {_ in }, onSpeedTap: {})
}
