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
    
    var body: some View {
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
                in: 0...max(totalTime, 1)
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

    
    private func formatTime(seconds: Double) -> String {
        guard seconds.isFinite else { return "00:00" }
        
        let min = Int(seconds) / 60
        let sec = Int(seconds) % 60
        return String(format: "%02d:%02d", min, sec)
    }
}

#Preview {
    VideoProgressBar(totalTime: 32.54, currentTime: 12.32, onSeek: {_ in })
}
