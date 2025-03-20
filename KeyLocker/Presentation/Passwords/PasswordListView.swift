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
            VStack {
                if viewModel.filteredPasswords.isEmpty {
                    EmptyContentView(
                        systemImage: "text.page.badge.magnifyingglass",
                        text: "No keys found."
                    )
                } else {
                    List {
                        // MARK: Keys list
                        ForEach(
                            viewModel.filteredPasswords,
                            id: \.id
                        ) { password in
                            NavigationLink {
                                PasswordDetailView(id: password.id)
                            } label: {
                                PasswordItemView(password: password)
                            }
                        }
                        // MARK: Delete key
                        .onDelete(perform: viewModel.removePassword)
                    }
                    // MARK: Searchbar
                    .searchable(
                        text: $viewModel.query,
                        placement: 
                                .navigationBarDrawer(displayMode: .automatic),
                        prompt: Text("Search key")
                    )
                    .listStyle(.sidebar)
                }
                
                // MARK: Add key button
                
            }
            .onAppear {
                viewModel.getPasswords()
            }
            .navigationTitle("My keys")
            .navigationBarTitleDisplayMode(.inline)
            // MARK: Toolbar
            .toolbar {
                // MARK: Settings button
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        
                    } label: {
                        Button("Settings", systemImage: "slider.horizontal.3") {
                            
                        }
                    }
                }
                
                ToolbarItem(placement: .status) {
                    NavigationLink {
                        NewPasswordView()
                    } label: {
                        Label("Add key", systemImage: "plus")
                            .labelStyle(.titleAndIcon)
                            .fixedSize()
                    }
                }
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
