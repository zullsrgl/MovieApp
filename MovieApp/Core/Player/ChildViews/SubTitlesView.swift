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

enum LanguageCode {
    static func code(for code: String) -> String {
        switch code {
        case "fr", "fr-FR":
            return "FR"
        case "fr-CA":
            return "FR"
        case "en":
            return "EN"
        case "cmn-Hans":
            return "CMN"
        case "cmn-Hant":
            return "CMN"
        default:
            return code.uppercased()
        }
    }
}

enum SubtitleMode: Int {
    case on = 0
    case off = 1
}

struct SubTitlesView: View {
    var titles: [String]
    var subtitleGroup: AVMediaSelectionGroup?
    var playerItem: AVPlayerItem?
    var subTitleSelected: (String) -> Void
    
    @State private var mode: SubtitleMode = .on
    @State private  var selectedLanguage: String?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            
            Picker("Subtitle", selection: $mode) {
                Text("Subtitle On").tag(SubtitleMode.on)
                Text("Subtitle Off").tag(SubtitleMode.off)
            }
            .pickerStyle(.segmented)
            .frame(width: 300)
            .padding()
            .onChange(of: mode) { newValue in
                if newValue == .off,
                   let group = subtitleGroup {
                    playerItem?.select(nil, in: group)
                    selectedLanguage = nil
                }
            }
            
            if mode == .on {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(titles, id: \.self) { language in
                        Button {
                            selectedLanguage = language
                            subTitleSelected(selectedLanguage ?? "")
                            if let group = subtitleGroup,
                               let option = group.options.first(where: {
                                   $0.locale?.identifier == language
                               }) {
                                playerItem?.select(option, in: group)
                            }
                        } label: {
                            
                            ZStack(alignment: .leading) {
                                
                                Rectangle()
                                    .foregroundStyle(Color("secondary").opacity(0.5))
                                    .frame(width: 200, height: 50)
                                    .cornerRadius(16)
                                
                                HStack {
                                    
                                    Text(LanguageCode.code(for: language))
                                        .padding(.all)
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundStyle(Color("secondary"))
                                        .background(Color("white").opacity(0.5))
                                        .cornerRadius(24)
                                        .padding(.all, 4)
                                    
                                    Text(LanguageNames.name(for: language))
                                        .foregroundStyle(.white)
                                        .font(.system(size: 16))
                                    
                                    Spacer()
                                    
                                    if selectedLanguage == language {
                                        Image(systemName: "checkmark.circle.fill")
                                            .frame(width: 16, height: 16)
                                            .padding(.trailing, 8)
                                    }
                                }
                                .frame(width: 200)
                            }
                        }
                    }
                }
                .frame(width: 400)
            }
        }
    }
}


#Preview {
    SubTitlesView(titles: ["Fransızca", "Çince (Basitleştirilmiş)", "İngilizce", "Çince (Geleneksel)"], subTitleSelected: {_ in})
}
