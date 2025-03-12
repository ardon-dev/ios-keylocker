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
    }
    
    // MARK: Insert password
    
    @Published
    var alias: String = ""
    @Published
    var password: String = ""
    func clearData() {
        alias = ""
        password = ""
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
            // TODO: Update these values
            user: "",
            icon: "",
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
