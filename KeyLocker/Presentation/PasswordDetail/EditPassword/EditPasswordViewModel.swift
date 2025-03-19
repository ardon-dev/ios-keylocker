//
//  EditPasswordViewModel.swift
//  KeyLocker
//
//  Created by Josue on 18/3/25.
//

import Foundation

class EditPasswordViewModel: ObservableObject {
    
    private var passwordModificationRepository: PasswordModificationRepository
    private var passwordRepository: PasswordRepository
    
    @Published
    var password: String = ""
    
    @Published
    var isSecured: Bool = false
    
    @Published
    var success: Bool = false
    
    @Published
    var updateError: String? = nil
    
    init(
        passwordModificationRepository: PasswordModificationRepository,
        passwordRepository: PasswordRepository,
        password: String
    ) {
        self.password = password
        self.passwordModificationRepository = passwordModificationRepository
        self.passwordRepository = passwordRepository
    }
    
    func addModification(currentPassword: PasswordDto) {
        let now = Date.now
        
        //Update password first
        let updatedPassword = PasswordDto(
            id: currentPassword.id,
            alias: currentPassword.alias,
            password: self.password,
            user: currentPassword.user,
            icon: currentPassword.icon,
            lastUpdate: now
        )
        let updatePasswordResult = passwordRepository.update(updatedPassword)
        switch updatePasswordResult {
        case .success(_):
            let dto = ModificationDto(
                date: currentPassword.lastUpdate,
                password: currentPassword.password,
                passwordId: currentPassword.id,
                modificationPassword: currentPassword
            )
            let result = passwordModificationRepository.insert(modificationDto: dto)
            switch result {
            case .success(let data):
                print(data)
                success = data
            case .failure(let error):
                print(error.localizedDescription)
                updateError = error.localizedDescription
            }
        case .failure(let error):
            updateError = error.localizedDescription
            print(error.localizedDescription)
        }
    }
    
}
