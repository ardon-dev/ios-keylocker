//
//  PasswordListView.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//

import SwiftUI

struct PasswordListView: View {
    
    @StateObject
    private var viewModel: PasswordListViewModel = PasswordListViewModel(
        passwordRepository: PasswordRepositoryImpl(
            controller: KeyLockerCDataController.shared
        )
    )
    
    var body: some View {
        NavigationStack {
            List {
                if viewModel.filteredPasswords.isEmpty {
                    EmptyContentView(
                        systemImage: "text.page.badge.magnifyingglass",
                        text: "No keys found."
                    )
                } else {
                    // MARK: Keys list
                    ForEach(viewModel.filteredPasswords, id: \.id) { password in
                        NavigationLink {
                            PasswordDetailView(id: password.id)
                        } label: {
                            PasswordItemView(password: password)
                        }
                    }
                    // MARK: Delete key
                    .onDelete(perform: viewModel.removePassword)
                }
            }
            // MARK: Searchbar
            .searchable(
                text: $viewModel.query,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: Text("Search key")
            )
            .listStyle(.plain)
            .navigationTitle("My keys")
            .navigationBarTitleDisplayMode(.inline)
            // MARK: Toolbar
            .toolbar {
                // MARK: Add button
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
