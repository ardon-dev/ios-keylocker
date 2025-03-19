//
//  PasswordDetailViewModel.swift
//  KeyLocker
//
//  Created by Josue on 11/3/25.
//

import Foundation

class PasswordDetailViewModel: ObservableObject {
    
    private var passwordRepository: PasswordRepository
    
    private var passwordModificationRepository: PasswordModificationRepository
    
    init(
        passwordRepository: PasswordRepository,
        passwordModificationRepository: PasswordModificationRepository
    ) {
        self.passwordRepository = passwordRepository
        self.passwordModificationRepository = passwordModificationRepository
    }
    
    @Published
    var visible: Bool = false
    
    @Published
    var error: String? = nil
    
    @Published
    var showError: Bool = false
    
    @Published
    var isEditing: Bool = false
    
    @Published
    var isEditingInfo: Bool = false
    
    /* Current password */
    
    @Published
    var currentPassword: PasswordDto? = nil
    
    func getPassword(_ id: UUID) {
        let result = passwordRepository.fetch(id: id)
        switch result {
        case .success(let data):
            showError = false
            currentPassword = data
            fetchModifications(passwordId: currentPassword?.id ?? UUID())
        case .failure(let error):
            self.error = error.localizedDescription
            showError = true
        }
    }
    
    /* Password modoifications */
    
    @Published
    var modifications: [ModificationDto] = []
    
    func fetchModifications(passwordId: UUID) {
        let result = passwordModificationRepository.fetchAllByPassword(
            passwordId: passwordId
        )
        switch result {
        case .success(let data):
            showError = false
            modifications = data.reversed()
        case .failure(let error):
            self.error = error.localizedDescription
            showError = true
        }
    }
    
    /* Remove modification */
    
    func removeModification(_ modification: ModificationDto) {
        let result = passwordModificationRepository.delete(modification)
        switch result {
        case .success(let data):
            showError = false
            print("Removed \(data)")
            let index: Int = modifications.firstIndex(where: { $0.id == modification.id }) ?? -1
            modifications.remove(at: index)
        case .failure(let error):
            self.error = error.localizedDescription
            showError = true
        }
    }
    
}
