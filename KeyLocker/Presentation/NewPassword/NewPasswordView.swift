//
//  NewPasswordView.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//

import SwiftUI

struct NewPasswordView: View {
    
    private var authHelper: AuthenticationHelper
    
    @Environment(\.dismiss)
    var dismiss
    
    @ObservedObject
    private var viewModel: NewPasswordViewModel
    
    @State
    var isSecured = false
    
    init() {
        self.viewModel = NewPasswordViewModel(
            passwordRepository: PasswordRepositoryImpl(
                controller: KeyLockerCDataController.shared
            )
        )
        self.authHelper = AuthenticationHelper()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // MARK: Key form
            Form {
                VStack(alignment: .leading) {
                    
                    // MARK: Title
                    Text("Enter your new Key").font(.title2).bold()
                        .listRowSeparator(.hidden)
                    
                    // MARK: Alias input
                    Text("Alias").padding(.top, 8)
                    TextField("", text: $viewModel.alias)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.default)
                    Text("Alias must contains at least 3 characters")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    // MARK: User or email input
                    Text("User or email").padding(.top, 8)
                    TextField("", text: $viewModel.user)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    Text("User or email must contains at least 3 characters")
                        .font(.caption)
                        .foregroundColor(.secondary)
                   
                    // MARK: Password input
                    Text("Password").padding(.top, 8)
                    HStack {
                        SecureTextField(
                            isSecured: $isSecured,
                            text: $viewModel.password
                        )
                      
                        // Generate random password button
                        Button(action: {
                            let randomPassword = generateRandomPassword()
                            viewModel.password = randomPassword
                            isSecured = true
                        }) {
                            Image(systemName: "shuffle")
                        }
                        .buttonStyle(.bordered)
                    }
                }
              
                // MARK: Icon selector
                Section {
                    IconSelectorView(
                        icons: $viewModel.icons,
                        icon: $viewModel.icon
                    )
                    .padding(.vertical, 8)
                }
            }
        }
        .toolbar {
            // MARK: Save key button
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", systemImage: "checkmark") {
                    viewModel.insertPassword()
                }
                .disabled(!viewModel.formIsValid)
            }
        }
        // MARK: Saved key alert
        .alert("Key saved successfully!", isPresented: $viewModel.insertPasswordSuccess) {
            Button("Ok") {
                dismiss()
            }
        }
        // MARK: Save key error alert
        .alert(viewModel.insertPasswordError ?? "", isPresented: $viewModel.showError) {
            Button("Ok") {
                dismiss()
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
    }
    
}

#Preview {
    NewPasswordView()
}
