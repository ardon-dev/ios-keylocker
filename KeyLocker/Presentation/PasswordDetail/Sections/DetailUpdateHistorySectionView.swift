//
//  DetailUpdateHistorySectionView.swift
//  KeyLocker
//
//  Created by Josue on 19/3/25.
//

import SwiftUI

struct DetailUpdateHistorySectionView: View {
    
    @Binding
    var visible: Bool
    
    var modifications: [ModificationDto]
    var onDelete: (_ modification: ModificationDto) -> Void
    
    var body: some View {
        Section(
            header: Label(
                "Update history",
                systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90"
            )
        ) {
            ForEach(modifications, id: \.id) { mod in
                ModificationItemView(
                    visible: $visible,
                    modification: mod
                )
                .swipeActions(edge: .trailing) {
                    Button("", systemImage: "trash") {
                        onDelete(mod)
                    }
                    .tint(.red)
                }
            }
        }
    }
}

#Preview {
    @Previewable
    @State
    var visible: Bool = false
    
    DetailUpdateHistorySectionView(
        visible: $visible,
        modifications: [ModificationDto(), ModificationDto()],
        onDelete: { _ in }
    )
}
