//
//  EditPasswordView.swift
//  KeyLocker
//
//  Created by Josue on 18/3/25.
//

import SwiftUI

struct EditPasswordView: View {
    
    @Environment(\.dismiss)
    var dismiss
    
    var password: PasswordDto
    
    @ObservedObject
    private var viewModel: EditPasswordViewModel
    
    init(password: PasswordDto) {
        self.password = password
        self.viewModel = EditPasswordViewModel(
            passwordModificationRepository: PasswordModificationRepositoryImpl(
                controller: KeyLockerCDataController.shared
            ),
            passwordRepository: PasswordRepositoryImpl(
                controller: KeyLockerCDataController.shared
            ),
            password: password.password
        )
    }
    
    var body: some View {
        VStack {
            // Sheet capsule
            Capsule()
                .fill(Color.secondary)
                .frame(width: 35, height: 5)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 16)
            
            // MARK: Edit password form
            Form {
                Section {
                    VStack(alignment: .leading) {
                        // Label
                        Text("Password")
                        
                        // MARK: Password input
                        HStack(alignment: .center) {
                            SecureTextField(
                                isSecured: $viewModel.isSecured,
                                text: $viewModel.password
                            )
                            
                            // MARK: Random password button
                            Button(action: {
                                let randomPassword = generateRandomPassword()
                                viewModel.password = randomPassword
                                viewModel.isSecured = true
                            }) {
                                Image(systemName: "shuffle")
                            }
                            .buttonStyle(.bordered)
                        }
                      
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .background(Color(UIColor.systemGray6))
        // MARK: Success update alert
        .alert("Password updated", isPresented: $viewModel.success) {
            Button("Ok") { dismiss() }
        }
        
        // MARK: Save button
        Button("Save") {
            viewModel.addModification(currentPassword: password)
        }
        .padding(.top, 8)
        .frame(
            maxWidth: .infinity,
            alignment: .center
        )
    }
}

#Preview {
    EditPasswordView(password: PasswordDto())
}
