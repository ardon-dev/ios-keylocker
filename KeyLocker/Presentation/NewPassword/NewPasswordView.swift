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
        VStack {
            Form {
                TextField("Alias", text: $viewModel.alias)
                TextField("Contraseña", text: $viewModel.password)
            }
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
    }
    
}

#Preview {
    NewPasswordView()
}
