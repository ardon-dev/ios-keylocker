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
                    VStack(alignment: .center) {
                        Image(systemName: "text.page.badge.magnifyingglass")
                            .imageScale(.large)
                            .foregroundColor(.secondary)
                        Text("No keys")
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
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
                    }
                    .onDelete(perform: viewModel.removePassword)
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
