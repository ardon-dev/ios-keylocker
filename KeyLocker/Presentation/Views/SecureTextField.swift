//
//  SecureTextField.swift
//  KeyLocker
//
//  Created by Josue on 19/3/25.
//

import SwiftUI

struct SecureTextField: View {
    
    @Binding
    var isSecured: Bool
    
    @Binding
    var text: String
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecured {
                TextField("", text: $text)
                    .textFieldStyle(.roundedBorder)
            } else {
                SecureField("", text: $text)
                    .textFieldStyle(.roundedBorder)
            }
            Image(systemName: isSecured ? "eye.slash" : "eye")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
                .onTapGesture {
                    isSecured = !isSecured
                }
                .padding(.trailing, 8)
        }
    }
}

#Preview {
    @Previewable
    @State
    var isSecure = false
    
    @Previewable 
    @State
    var text = ""
    
    SecureTextField(
        isSecured: $isSecure,
        text: $text
    )
}
