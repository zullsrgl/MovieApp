//
//  ResolutionListView.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 29.12.2025.
//

import SwiftUI

struct ResolutionListView: View {
    var resolutions: [(String, Double)]
    var resolutionsSelected: (Double) -> Void
    @Binding var selectedResolution: String?
    
    
    var body: some View {
        
        List(resolutions, id: \.0){ res, value in
            Button {
                resolutionsSelected(value)
            } label: {
                HStack {
                    Text(res)
                    Spacer()
                    if selectedResolution == String(value) {
                        Image(systemName: "checkmark")
                    }
                    
                }
                
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    ResolutionListView(resolutions:  [], resolutionsSelected: {_ in}, selectedResolution: .constant(nil))
}
