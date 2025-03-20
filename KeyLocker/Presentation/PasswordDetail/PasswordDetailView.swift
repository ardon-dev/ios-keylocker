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
            ),
            passwordModificationRepository: PasswordModificationRepositoryImpl(
                controller: KeyLockerCDataController.shared
            )
        )
        self.authHelper = AuthenticationHelper()
    }
    
    var body: some View {
        List {
            
            // MARK: Key section
            DetailKeySectionView(
                visible: $viewModel.visible,
                alias: viewModel.currentPassword?.alias ?? "",
                icon: viewModel.currentPassword?.icon ?? "facebook",
                password: viewModel.currentPassword?.password ?? "",
                onEdit: {
                    viewModel.isEditing = true
                }
            )
            
            // MARK: Information section
            DetailInfoSectionView(
                user: viewModel.currentPassword?.user ?? "------",
                lastUpdate: viewModel.currentPassword?.lastUpdate ?? Date.now
            )
            
            // MARK: Update history section
            DetailUpdateHistorySectionView(
                visible: $viewModel.visible,
                modifications: viewModel.modifications,
                onDelete: { modification in
                    handleDelete(for: modification)
                }
            )
        }
        // MARK: Toolbar
        .toolbar {
            // MARK: Edit button
            ToolbarItem {
                Button("Edit", systemImage: "pencil") {
                    editKey()
                }
            }
            
            // MARK: Lock/Unlock button
            ToolbarItem(placement: .status) {
                Button(
                    viewModel.visible ? "Lock" : "Unlock",
                    systemImage: viewModel.visible ? "lock.open" : "lock"
                ) {
                    if viewModel.visible {
                        viewModel.visible = false
                    } else {
                        authenticate { success in
                            if success {
                                viewModel.visible = true
                            } else {
                                viewModel.visible = false
                            }
                        }
                    }
                }
                .labelStyle(.titleAndIcon)
            }
        }
        // MARK: Edit password sheet
        .sheet(
            isPresented: $viewModel.isEditing,
            onDismiss: { viewModel.getPassword(self.id) }
        ) {
            EditPasswordView(password: viewModel.currentPassword ?? PasswordDto())
        }
        // MARK: Edit info sheet
        .sheet(
            isPresented: $viewModel.isEditingInfo,
            onDismiss: { viewModel.getPassword(self.id) }
        ) {
            EditInfoView(password: viewModel.currentPassword ?? PasswordDto())
        }
        .onAppear {
            viewModel.getPassword(id)
        }
        .onDisappear {
            viewModel.visible = false
        }
        // MARK: Error alert
        .alert(viewModel.error ?? "", isPresented: $viewModel.showError) {
            Button("Ok") {
                viewModel.showError = false
                viewModel.error = nil
            }
        }
    }
    
    // MARK: Edit key
    private func editKey() {
        if viewModel.visible {
            viewModel.isEditingInfo = true
        } else {
            authenticate { success in
                if success {
                    viewModel.visible = true
                    viewModel.isEditingInfo = true
                } else {
                    viewModel.visible = false
                    viewModel.isEditingInfo = false
                }
            }
        }
    }
    
    // MARK: Authenticate at detail context
    private func authenticate(callback: @escaping (_ success: Bool) -> Void) {
        authHelper.authenticate { result in
            switch result {
            case .success(_):
                viewModel.showError = false
                viewModel.error = nil
                callback(true)
            case .failure(let error):
                viewModel.error = error.localizedDescription
                viewModel.showError = true
                callback(false)
            }
        }
    }
    
    // MARK: Delete modification implementation
    private func handleDelete(for modification: ModificationDto) {
        if viewModel.visible {
            viewModel.removeModification(modification)
        } else {
            authenticate { success in
                if success {
                    viewModel.removeModification(modification)
                }
            }
        }
    }
    
}

#Preview {
    PasswordDetailView(id: UUID())
}
