//
//  EmptyContentView.swift
//  KeyLocker
//
//  Created by Josue on 19/3/25.
//

import SwiftUI

struct EmptyContentView: View {
    
    let systemImage: String
    let text: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: systemImage)
                .imageScale(.large)
                .foregroundColor(.secondary)
            Text(text)
                .font(.callout)
                .foregroundColor(.secondary)
                .padding(.top, 4)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .center
        )
        .listRowSeparator(.hidden)
    }
}

#Preview {
    EmptyContentView(
        systemImage: "text.page.badge.magnifyingglass",
        text: "Preview"
    )
}
