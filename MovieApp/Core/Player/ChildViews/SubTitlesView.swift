//
//  SubTitlesView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 25.12.2025.
//

import SwiftUI
import AVFoundation

enum LanguageNames {
    static func name(for code: String) -> String {
        switch code {
        case "fr", "fr-FR":
            return "French"
        case "fr-CA":
            return "French(Canada)"
        case "en":
            return "English"
        case "cmn-Hans":
            return "Chinese(Simplified)"
        case "cmn-Hant":
            return "Chinese(Traditional)"
        default:
            return Locale.current.localizedString(forIdentifier: code) ?? code
        }
    }
}

struct SubTitlesView: View {
    var titles: [String]
    var subTitleSelected: (String) -> Void
    
    @Binding var selectedLanguage: String?
    
    var body: some View {
        List {
            Button {
                selectedLanguage = nil
                subTitleSelected("off")
            } label: {
                HStack {
                    Text("Subtitles Off")
                    Spacer()
                    if selectedLanguage == nil {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            ForEach(titles, id: \.self) { code in
                let title = LanguageNames.name(for: code)
                
                Button {
                    selectedLanguage = code
                    subTitleSelected(code)
                } label: {
                    HStack {
                        Text(title)
                        Spacer()
                        if selectedLanguage == code {
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
    //    SubTitlesView(titles: [], subTitleSelected: {_ in}, selectedLanguage: )
}
