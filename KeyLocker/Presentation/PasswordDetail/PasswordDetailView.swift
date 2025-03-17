//
//  PasswordDetailView.swift
//  KeyLocker
//
//  Created by Josue on 11/3/25.
//

import SwiftUI
import LocalAuthentication

struct PasswordDetailView: View {
    
    let id: UUID
    
    @ObservedObject
    private var viewModel: PasswordDetailViewModel
    
    private var authHelper: AuthenticationHelper
    
    init(id: UUID) {
        self.id = id
        self.viewModel = PasswordDetailViewModel(
            passwordRepository: PasswordRepositoryImpl(
                controller: KeyLockerCDataController.shared
            )
        )
        self.authHelper = AuthenticationHelper()
    }
    
    var body: some View {
        List {
            Section(header: Label("Password", systemImage: viewModel.currentPassword?.icon ?? "key.fill")) {
                PasswordDetailHeadView(
                    password: viewModel.currentPassword,
                    visible: $viewModel.visible,
                    authHelper: self.authHelper
                )
            }
            
            Section(header: Label("Information", systemImage: "info.circle.fill")) {
                PasswordDetailInfoView(password: viewModel.currentPassword)
            }
            
            Section(header: Label("Update history", systemImage: "arrow.clockwise.circle.fill")) {
                ForEach(["Update 1", "Update 2"], id: \.self) { update in
                    ModificationItemView()
                }
            }
            
        }
        .navigationTitle(viewModel.currentPassword?.alias ?? "")
        .toolbar {
            ToolbarItem {
                Button(
                    "",
                    systemImage: viewModel.visible ? "lock.open" : "lock"
                ) {
                    if viewModel.visible {
                        viewModel.visible = false
                    } else {
                        authHelper.authenticate { result in
                            switch result {
                            case .success(_):
                                print("Authenticated")
                                viewModel.visible = true
                            case .failure(let error):
                                print(error.localizedDescription)
                                viewModel.visible = false
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.getPassword(id)
        }
        .onDisappear {
            viewModel.visible = false
        }
    }
    
}

struct PasswordDetailHeadView: View {
    
    var password: PasswordDto? = nil

    @Binding
    var visible: Bool
    
    var authHelper: AuthenticationHelper
    
    var body: some View {
        VStack {
            Text(visible ? password?.password ?? "******" : "******")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity)
            
            if visible {
                HStack {
                    Button(action: {
                    }) {
                        HStack {
                            Image(systemName: "square.and.pencil")
                                .frame(height: 24)
                            Text("Edit")
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "document.on.document")
                                .frame(height: 24)
                            Text("Copy")
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .padding(16)
        .frame(
            maxWidth: .infinity
        )
    }
}

struct PasswordDetailInfoView: View {
    
    var password: PasswordDto? = nil
    
    var body: some View {
        LabeledContent("User", value: password?.user ?? "user")
        let date = formatDate(
            password?.lastUpdate ?? Date.now,
            format: "d MMM yyyy, h:mm a"
        )
        LabeledContent("Last update", value: date)
    }
}



#Preview {
    PasswordDetailView(id: UUID())
}
