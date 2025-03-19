//
//  DetailInfoSectionView.swift
//  KeyLocker
//
//  Created by Josue on 19/3/25.
//

import SwiftUI

struct DetailInfoSectionView: View {
    
    var user: String
    var lastUpdate: Date
    
    var body: some View {
        Section(header: Label("Information", systemImage: "info.circle")) {
            LabeledContent("User", value: user)
            let date = formatDate(
                lastUpdate,
                format: "d MMM yyyy, h:mm a"
            )
            LabeledContent("Last update", value: date)
        }
    }
}

#Preview {
    DetailInfoSectionView(
        user: "preview",
        lastUpdate: Date.now
    )
}
