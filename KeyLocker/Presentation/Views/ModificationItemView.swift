//
//  ModificationItemView.swift
//  KeyLocker
//
//  Created by Josue on 13/3/25.
//

import SwiftUI

struct ModificationItemView: View {
    
    @Binding
    var visible: Bool
    
    var modification: ModificationDto
    
    var body: some View {
        HStack {
            Image(systemName: visible ? "lock.open" : "lock")
            Spacer(minLength: 16)
            VStack {
                Text(
                    formatDate(modification.date, format: "d MMM yyyy, h:mm a")
                )
                .font(.caption)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .foregroundColor(.secondary)
                Text(visible ? modification.password : "******")
                    .font(.body)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
        }
    }
}

#Preview {
    @State
    var visible = false
    ModificationItemView(visible: $visible, modification: ModificationDto())
}
