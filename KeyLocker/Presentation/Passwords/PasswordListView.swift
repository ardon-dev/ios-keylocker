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
                if !viewModel.query.isEmpty {
                    Label(
                        "No keys found.",
                        systemImage: "text.page.badge.magnifyingglass"
                    )
                    .listRowSeparator(.hidden)
                    .frame(alignment: .center)
                } else {
                    ForEach(viewModel.filteredPasswords, id: \.id) { password in
                        Button(action: {}) {
                            PasswordItemView(password: password)
                        }
                        .background(
                            NavigationLink {
                                PasswordDetailView(id: password.id)
                            } label: {
                                EmptyView()
                            }
                        )
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }
                    .onDelete(perform: viewModel.removePassword)
                }
            }
            .padding(.horizontal, 16)
            .searchable(
                text: $viewModel.query,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: Text("Search key")
            )
            .listStyle(.plain)
            .listRowSpacing(8)
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
