//
//  PasswordListView.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//

import SwiftUI

struct PasswordListView: View {
    
    @ObservedObject
    private var viewModel: PasswordListViewModel
    
    init() {
        self.viewModel = PasswordListViewModel(
            passwordRepository: PasswordRepositoryImpl(
                controller: KeyLockerCDataController.shared
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($viewModel.passwords, id: \.id) { password in
                    PasswordItemView(password: password.wrappedValue)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let item = viewModel.passwords[index]
                        viewModel.removePassword(item)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("My keys")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        NewPasswordView()
                    } label: {
                        Button("Add", systemImage: "plus") {
                            
                        }
                    }
                }
            }
            .onAppear {
                viewModel.getPasswords()
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
    
}

#Preview {
    PasswordListView()
}
