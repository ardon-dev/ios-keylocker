//
//  PasswordDetailView.swift
//  KeyLocker
//
//  Created by Josue on 11/3/25.
//

import SwiftUI

struct PasswordDetailView: View {
    
    let id: UUID
    
    @ObservedObject
    private var viewModel: PasswordDetailViewModel
    
    init(id: UUID) {
        self.id = id
        self.viewModel = PasswordDetailViewModel(
            passwordRepository: PasswordRepositoryImpl(
                controller: KeyLockerCDataController.shared
            )
        )
    }
    
    var body: some View {
        List {
            Section {
                PasswordDetailHeadView(
                    password: viewModel.currentPassword,
                    visible: viewModel.visible
                )
            }
            .listRowSeparator(.hidden)

            
            Section {
                PasswordDetailInfoView(password: viewModel.currentPassword)
                    .padding(.top, 16)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle(viewModel.currentPassword?.alias ?? "")
        .onAppear {
            viewModel.getPassword(id)
        }
    }
}

struct PasswordDetailHeadView: View {
    
    var password: PasswordDto? = nil
    var visible: Bool = false
    
    var body: some View {
        VStack {
            if visible {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "square.and.pencil")
                            .frame(height: 24)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(action: {}) {
                        Image(systemName: "document.on.document")
                            .frame(height: 24)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            Spacer(minLength: 16)
            Text(visible ? password?.password ?? "******" : "******")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity)
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
        VStack {
            Text("Email or username")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            Text(password?.user ?? "User")
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer(minLength: 16)
            Text("Last update")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            Text(password?.lastUpdate.description ?? "Date")
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer(minLength: 16)
            Text("Update history")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            ForEach(["Update 1", "Update 2"], id: \.self) { update in
                PasswordItemView(password: PasswordDto())
            }
            Spacer().background(.red)
        }
    }
}



#Preview {
    PasswordDetailView(id: UUID())
}
