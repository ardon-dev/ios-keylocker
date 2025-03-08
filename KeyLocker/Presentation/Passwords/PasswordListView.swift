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
        let filtered = viewModel.query.isEmpty
        ? viewModel.passwords
        : viewModel.passwords
            .filter { $0.alias.localizedCaseInsensitiveContains(viewModel.query) }
        
        NavigationStack {
            List {
                if filtered.isEmpty {
                    Label("No keys found.", systemImage: "text.page.badge.magnifyingglass")
                        .listRowSeparator(.hidden)
                        .frame(alignment: .center)
                } else {
                    ForEach(filtered, id: \.id) { password in
                        PasswordItemView(password: password)
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let item = viewModel.passwords[index]
                            viewModel.removePassword(item)
                        }
                    }
                }
            }
            .searchable(
                text: $viewModel.query,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: Text("Search key")
            )
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
