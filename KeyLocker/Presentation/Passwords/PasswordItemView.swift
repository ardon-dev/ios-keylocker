//
//  PasswordItemView.swift
//  KeyLocker
//
//  Created by Josue on 6/3/25.
//

import SwiftUI

struct PasswordItemView: View {
    
    let password: PasswordDto
    
    var body: some View {
        HStack {
            Image(systemName: "key")
            Spacer(minLength: 16)
            VStack {
                Text(password.alias)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                Text("Last update: -------")
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
        .listRowSeparator(.hidden)
        .padding(16)
        .background(.bar)
        .cornerRadius(16)
        .frame(
            maxWidth: .infinity,
            alignment: .top
        )
    }
}

#Preview {
    PasswordItemView(password: PasswordDto())
}
