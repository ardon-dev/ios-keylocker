//
//  NewPasswordViewModel.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//

import Foundation

class NewPasswordViewModel: ObservableObject {
    
    private var passwordRepository: PasswordRepository
    
    init(passwordRepository: PasswordRepository) {
        self.passwordRepository = passwordRepository
        self.icons = [
            "key",
            "key.2.on.ring.fill",
            "keyboard",
            "network.badge.shield.half.filled",
            "checkmark.seal.fill",
            "shield.lefthalf.filled.badge.checkmark",
            "eye"
        ]
        self.icon = icons[0]
    }
    
    // MARK: Insert password
    
    @Published
    var alias: String = ""
    
    @Published
    var password: String = ""
    
    @Published
    var user: String = ""
    
    @Published
    var icons: [String]
    
    @Published
    var icon: String = ""
    
    func clearData() {
        alias = ""
        password = ""
        user = ""
        icon = icons[0]
    }
    
    @Published
    var insertPasswordSuccess: Bool = false
    
    @Published
    var insertPasswordError: String? = nil
    
    @Published
    var showError: Bool = false
    
    func insertPassword() {
        let passwordDto = PasswordDto(
            id: UUID(),
            alias: self.alias,
            password: self.password,
            user: self.user,
            icon: self.icon,
            lastUpdate: Date.now
        )
        let result = passwordRepository.insert(passwordDto)
        switch result {
        case .success(let data):
            insertPasswordError = nil
            showError = false
            insertPasswordSuccess = data
        case .failure(let error):
            showError = true
            insertPasswordError = error.localizedDescription
        }
    }
    
}
