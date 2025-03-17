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
            Image(systemName: password.icon.isEmpty ? "key" : password.icon)
                .imageScale(.large)
            Spacer(minLength: 16)
            VStack {
                Text(password.alias)
                    .font(.headline)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                let date = formatDate(password.lastUpdate, format: "d MMM yyyy, h:mm a")
                Text("Last update: \(date)")
                    .font(.callout)
                    .foregroundColor(.gray)
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
        .frame(
            maxWidth: .infinity,
            alignment: .top
        )
        .onAppear {
            print(password.icon)
        }
    }
}

#Preview {
    PasswordItemView(password: PasswordDto())
}
