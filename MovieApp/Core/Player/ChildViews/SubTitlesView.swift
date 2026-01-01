//
//  SubTitlesView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 25.12.2025.
//

import SwiftUI
import AVFoundation

struct SubTitlesView: View {
    var subtitles: [AVMediaSelectionOption]
    var selectedSubtitle: (AVMediaSelectionOption?) -> Void
    
    @Binding var selectedLanguage: AVMediaSelectionOption?
    
    var body: some View {
        List {
            Button {
                selectedLanguage = nil
                selectedSubtitle(nil)
            } label: {
                HStack {
                    Text("Subtitl Off")
                    Spacer()
                    if selectedLanguage == nil {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            ForEach(subtitles, id: \.self) { option in
                  let title = option.displayName

                  Button {
                      selectedLanguage = option
                      selectedSubtitle(option)
                  } label: {
                      HStack {
                          Text(title)
                          Spacer()
                          if selectedLanguage == option {
                              Image(systemName: "checkmark")
                          }
                      }
                  }
              }
          }
        .listStyle(.plain)
        .background(Color.black)
        .onAppear{
        }
    }
}

#Preview {
    SubTitlesView(subtitles: [], selectedSubtitle: {_ in }, selectedLanguage: .constant(nil))
}
