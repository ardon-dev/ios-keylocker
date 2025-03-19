//
//  EditInfoView.swift
//  KeyLocker
//
//  Created by Josue on 18/3/25.
//

import SwiftUI

struct EditInfoView: View {
    
    @Environment(\.dismiss)
    var dismiss
    
    var password: PasswordDto
    
    @ObservedObject
    private var viewModel: EditInfoViewModel
    
    init(password: PasswordDto) {
        self.password = password
        self.viewModel = EditInfoViewModel(
            passwordRepository: PasswordRepositoryImpl(controller: KeyLockerCDataController.shared),
            alias: password.alias,
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
                        Text("Edit your key").font(.title2).bold()
                        Text("Alias").padding(.top, 8)
                        TextField("Alias", text: $viewModel.alias)
                            .textFieldStyle(.roundedBorder)
                        
                        Text("User or Email").padding(.top, 8)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        TextField("User or email", text: $viewModel.user)
                            .textFieldStyle(.roundedBorder)
                    }
                    .frame(
                        maxWidth: .infinity
                    )
                }
            
                Section {
                    IconSelectorView(icons: $viewModel.icons, icon: $viewModel.icon)
                }
                
                Button("Save") {
                    viewModel.updatePassword(password: password)
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
    EditInfoView(password: PasswordDto())
}
