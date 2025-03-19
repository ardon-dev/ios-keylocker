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
            alias: password.alias,
            password: password.password,
            user: password.user,
            icon: password.icon
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
                        /*
                        Text("Edit your key").font(.title2).bold()
                        Text("Alias").padding(.top, 8)
                        TextField("Alias", text: $viewModel.alias)
                            .textFieldStyle(.roundedBorder)
                        
                        Text("User or Email").padding(.top, 8)
                        TextField("User or email", text: $viewModel.user)
                            .textFieldStyle(.roundedBorder)
                        
                         */
                        //Text("Password").padding(.top, 8)
                        HStack {
                            if viewModel.isSecured {
                                TextField("Password", text: $viewModel.password)
                            } else {
                                SecureField("Password", text: $viewModel.password)
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
                
                /*
                Section {
                    IconSelectorView(icons: $viewModel.icons, icon: $viewModel.icon)
                }
                 */
                
                Button("Save") {
                    viewModel.addModification(currentPassword: password)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
        }
        .background(Color(UIColor.systemGray6))
        .alert("Password updated", isPresented: $viewModel.success) {
            Button("Ok") { dismiss() }
        }
    }
}

#Preview {
    EditPasswordView(password: PasswordDto())
}
