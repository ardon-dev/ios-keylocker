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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter your new Key").font(.title2).bold()
            Spacer(minLength: 16)
            
            Text("Alias").font(.callout)
            TextField("Alias", text: $viewModel.alias)
                .textFieldStyle(.roundedBorder)
            
            Text("User or Email").font(.callout)
            TextField("User or email", text: $viewModel.user)
                .textFieldStyle(.roundedBorder)
            
            Text("Password").font(.callout)
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
          
            Spacer(minLength: 24)
            IconSelectorView(
                icons: $viewModel.icons,
                icon: $viewModel.icon
            )
            Button("Save") {
                viewModel.insertPassword()
            }
            .buttonStyle(.borderedProminent)

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
        .navigationTitle("New Key")
        .padding(16)
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
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(icons, id: \.self) { item in
                        let selected = icon == item
                        Button(action: {
                            icon = item
                        }) {
                            Image(systemName: item)
                                .frame(width: 24, height: 24)
                                .foregroundColor(
                                    selected ? .accentColor : .gray
                                )
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
