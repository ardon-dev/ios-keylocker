//
//  EditInfoViewModel.swift
//  KeyLocker
//
//  Created by Josue on 18/3/25.
//

import Foundation

class EditInfoViewModel: ObservableObject {
    
    private var passwordRepository: PasswordRepository
    
    @Published
    var alias: String = ""
    
    @Published
    var user: String = ""
    
    @Published
    var icons: [String]
    
    @Published
    var icon: String = ""
    
    init(
        passwordRepository: PasswordRepository,
        alias: String,
        user: String,
        icon: String
    ) {
        self.passwordRepository = passwordRepository
        self.alias = alias
        self.user = user
        self.icons = [
            "key",
            "key.2.on.ring.fill",
            "keyboard",
            "network.badge.shield.half.filled",
            "checkmark.seal.fill",
            "shield.lefthalf.filled.badge.checkmark",
            "eye"
        ]
        self.icon = icon
    }
    
    /* Update password info */
    
    @Published
    var success: Bool = false
    
    @Published
    var updateError: String? = nil
    
    func updatePassword(password: PasswordDto) {
        let updatedPassword = PasswordDto(
            id: password.id,
            alias: self.alias,
            password: password.password,
            user: self.user,
            icon: self.icon,
            lastUpdate: password.lastUpdate,
            objectID: password.objectID
        )
        let result = passwordRepository.update(updatedPassword)
        switch result {
        case .success(_):
            success = true
        case .failure(let error):
            updateError = error.localizedDescription
        }
    }
    
}
