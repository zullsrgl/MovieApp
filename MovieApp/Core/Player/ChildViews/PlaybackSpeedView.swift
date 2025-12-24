//
//  PlaybackSpeed.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 24.12.2025.


import SwiftUI
struct PlaybackSpeedView: View {
    
    @Binding var rateIndex: Int
    
    let playbackRates: [Float] = [0.5, 0.75, 1.0, 1.25, 1.5]
    var onSelect: (Float) -> Void
    var onClose: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .trailing, spacing: 16) {
                    Button(action: {
                        onClose()
                    }){
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(Color("white"))
                            .frame(width: 16, height:  16)
                    }
                    .padding(.horizontal)
                    
                    Slider(
                        value: Binding(
                            get: { Double(rateIndex) },
                            set: { newValue in
                                rateIndex = Int(newValue.rounded())
                                onSelect(playbackRates[rateIndex])
                            }
                        ),
                        in: 0...Double(playbackRates.count - 1),
                        step: 1
                    )
                    .tint(Color("gary"))
                    
                    HStack {
                        ForEach(playbackRates.indices, id: \.self) { i in
                            Text("\(playbackRates[i], specifier: "%.2f")x")
                                .font(.headline)
                                .foregroundStyle(
                                    i == rateIndex ? .white : .gray
                                )
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .ignoresSafeArea()
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color("black").opacity(0.9))
                        .blur(radius: 4)
                )
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PlaybackSpeedView(rateIndex: .constant(2), onSelect: { _ in }, onClose: {})
}
