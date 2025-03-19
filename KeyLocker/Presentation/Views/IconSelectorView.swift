//
//  IconSelectorView.swift
//  KeyLocker
//
//  Created by Josue on 19/3/25.
//

import SwiftUI

struct IconSelectorView: View {
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Binding
    var icons: [String]
    
    @Binding
    var icon: String
    
    var body: some View {
        VStack {
            
            // Header text
            Text("Choose an icon")
                .font(.title2)
                .bold()
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            Spacer(minLength: 16)
            
            // Icons grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(icons, id: \.self) { item in
                        let selected = icon == item
                        if selected {
                            Button(action: {
                                icon = item
                            }) {
                                Image(item)
                                    .frame(width: 24, height: 24)
                            }
                            .buttonStyle(.borderedProminent)
                        } else {
                            Button(action: {
                                icon = item
                            }) {
                                Image(item)
                                    .frame(width: 24, height: 24)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    
    @Previewable
    @State
    var icons = appIcons()
    
    @Previewable
    @State
    var icon = ""
    
    IconSelectorView(
        icons: $icons,
        icon: $icon
    )
}
