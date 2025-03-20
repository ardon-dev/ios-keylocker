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
        NavigationView {
            VStack {
               
                Capsule()
                       .fill(Color.secondary)
                       .frame(width: 35, height: 5)
                       .frame(maxWidth: .infinity, alignment: .center)
                       .padding(.top, 16)
                
                // MARK: Edit form
                Form {
                    // Sections
                    InfoSection()
                    IconSelectorSection()
                }
            }
            .background(Color(UIColor.systemGray6))
            // MARK: Success update alert
            .alert("Password updated", isPresented: $viewModel.success) {
                Button("Ok") { dismiss() }
            }
            // MARK: Toolbar
            .toolbar {
                // MARK: Save button
                ToolbarItem(placement: .bottomBar) {
                    Button("Save") {
                        viewModel.updatePassword(password: password)
                    }
                    .labelStyle(.titleAndIcon)
                }
            }
        }
    }
    
    // MARK: Information section
    @ViewBuilder
    func InfoSection() -> some View {
        Section {
            VStack(alignment: .leading) {
                // Title
                Text("Edit your key").font(.title2).bold()
                
                // MARK: Alias input
                Text("Alias").padding(.top, 8)
                TextField("Alias", text: $viewModel.alias)
                    .textFieldStyle(.roundedBorder)
                
                // MARK: User input
                Text("User or Email").padding(.top, 8)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                TextField("User or email", text: $viewModel.user)
                    .textFieldStyle(.roundedBorder)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    // MARK: Icon selector section
    @ViewBuilder
    func IconSelectorSection() -> some View {
        Section {
            IconSelectorView(icons: $viewModel.icons, icon: $viewModel.icon)
        }
    }
}

#Preview {
    EditInfoView(password: PasswordDto())
}
