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
            passwordRepository: PasswordRepositoryImpl(controller: KeyLockerCDataController.shared),
            password: password.password
        )
    }
    
    var body: some View {
        VStack {
            Capsule()
                   .fill(Color.secondary)
                   .frame(width: 35, height: 5)
                   .frame(maxWidth: .infinity, alignment: .center)
                   .padding(.top, 16)
            
            Form {
                
                Section {
                    VStack(alignment: .leading) {
                        Text("Password")
                        HStack(alignment: .center) {
                            if viewModel.isSecured {
                                TextField("", text: $viewModel.password)
                                    .textFieldStyle(.roundedBorder)
                            } else {
                                SecureField("", text: $viewModel.password)
                                    .textFieldStyle(.roundedBorder)
                            }
                            Image(systemName: viewModel.isSecured ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    viewModel.isSecured = !viewModel.isSecured
                                }
                        }
                      
                    }
                    .frame(
                        maxWidth: .infinity
                    )
                }
                
                Section {
                    Button("Generate", systemImage: "shuffle") {
                        let randomPassword = generateRandomPassword()
                        viewModel.password = randomPassword
                        viewModel.isSecured = true
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .center
                    )
                }
            }
        }
        .background(Color(UIColor.systemGray6))
        .alert("Password updated", isPresented: $viewModel.success) {
            Button("Ok") { dismiss() }
        }
        
        Button("Save") {
            viewModel.addModification(currentPassword: password)
        }
        .padding(.top, 8)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    EditPasswordView(password: PasswordDto())
}
