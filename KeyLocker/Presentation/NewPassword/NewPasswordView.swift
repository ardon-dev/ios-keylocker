//
//  NewPasswordView.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//

import SwiftUI

struct NewPasswordView: View {
    
    @Environment(\.dismiss)
    var dismiss
    
    @ObservedObject
    private var viewModel: NewPasswordViewModel
    
    init() {
        self.viewModel = NewPasswordViewModel(
            passwordRepository: PasswordRepositoryImpl(
                controller: KeyLockerCDataController.shared
            )
        )
    }
    
    @State
    var isSecured = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Form {
                Text("Enter your new Key").font(.title2).bold()
                    .listRowSeparator(.hidden)
                TextField("Alias", text: $viewModel.alias)
                    .keyboardType(.default)
                TextField("User or email", text: $viewModel.user)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                HStack {
                    if isSecured {
                        TextField("Password", text: $viewModel.password)
                    } else {
                        SecureField("Password", text: $viewModel.password)
                    }
                    Image(systemName: isSecured ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .onTapGesture {
                            isSecured = !isSecured
                        }
                }
                
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
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", systemImage: "checkmark") {
                    viewModel.insertPassword()
                }
                .disabled(!viewModel.formIsValid)
            }
        }
        .alert("Exitoso", isPresented: $viewModel.insertPasswordSuccess) {
            Button("Ok") {
                dismiss()
            }
        }
        .sheet(isPresented: $viewModel.showError) {
            Text("\($viewModel.insertPasswordError)")
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
    }
    
}

struct IconSelectorView: View {
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Binding
    var icons: [String]
    
    @Binding
    var icon: String
    
    var body: some View {
        VStack {
            Text("Choose an icon")
                .font(.title2)
                .bold()
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            Spacer(minLength: 16)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(icons, id: \.self) { item in
                        let selected = icon == item
                        if selected {
                            Button(action: {
                                icon = item
                            }) {
                                Image(systemName: item)
                                    .frame(width: 24, height: 24)
                            }
                            .buttonStyle(.borderedProminent)
                        } else {
                            Button(action: {
                                icon = item
                            }) {
                                Image(systemName: item)
                                    .frame(width: 24, height: 24)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewPasswordView()
}
