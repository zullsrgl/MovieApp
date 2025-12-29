//
//  VideoProgressBar.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 18.12.2025.
//

import SwiftUI
import AVFoundation

struct ProgressBarView: View {
    var totalTime: Double
    var currentTime: Double
    var onSeek: (Double) -> Void
    var subtitles: [AVMediaSelectionOption]
    var selecedSubTitle: (AVMediaSelectionOption) -> Void
    var speedIndexSelected: (Float) -> Void
    @Binding var rateIndex: Int
    
    @State private var selectedSubtitle: AVMediaSelectionOption?
    @State private var showSubTitleSheet = false
    @State private var showSpeetTapped = false
    @State private var editingValue: Double? = nil
    
    var body: some View {
        VStack{
            HStack {
                Text(formatTime(seconds: currentTime))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("white"))
                    .frame(width: 44, alignment: .leading)
                
                Slider(
                    value: Binding(
                        get: { editingValue ?? currentTime },
                        set: { newValue in
                            editingValue = newValue
                        }
                    ),
                    in: 0...totalTime,
                    onEditingChanged: { editing in
                        if !editing {
                            if let value = editingValue {
                                onSeek(value)
                            }
                            editingValue = nil
                        }
                    }
                )
                .tint(Color("primary"))
                Text("-" + formatTime(seconds: max(totalTime - currentTime, 0)))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("white"))
                    .frame(width: 44, alignment: .trailing)
            }
            .ignoresSafeArea()
            
            HStack{
                Button(action: {
                    showSpeetTapped = true
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
                .sheet(isPresented:  $showSpeetTapped){
                    
                    Capsule()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 80, height: 5)
                        .padding(.top, 8)
                        .padding(.bottom, 20)
                    
                    PlaybackSpeedView(rateIndex: $rateIndex) { index in
                        speedIndexSelected(index)
                    }
                    .offset(y: 200)
                }
                
                Button(action: {
                    showSubTitleSheet = true
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
                .sheet(isPresented: $showSubTitleSheet) {
                    VStack {
                        Capsule()
                            .fill(Color.white.opacity(0.5))
                            .frame(width: 80, height: 5)
                            .padding(.top, 8)
                            .padding(.bottom, 20)
                        
                        SubTitlesView(
                            subtitles: subtitles,
                            selectedSubtitle: { option in
                                guard let option = option else { return}
                                selecedSubTitle(option)
                                
                            },
                            selectedLanguage: $selectedSubtitle
                        )
                        .frame(maxHeight: .infinity)
                    }
                }
            }
        }
    }
    
    private func formatTime(seconds: Double) -> String {
        guard seconds.isFinite else { return "00:00" }
        
        let min = Int(seconds) / 60
        let sec = Int(seconds) % 60
        return String(format: "%02d:%02d", min, sec)
    }
}

#Preview {
    ProgressBarView(totalTime: 12.3, currentTime: 21.3, onSeek: {_ in}, subtitles: [], selecedSubTitle: {_ in}, speedIndexSelected: {_ in}, rateIndex: .constant(9))
}
