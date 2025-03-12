//
//  PasswordDetailViewModel.swift
//  KeyLocker
//
//  Created by Josue on 11/3/25.
//

import Foundation

class PasswordDetailViewModel: ObservableObject {
    
    private var passwordRepository: PasswordRepository
    
    init(passwordRepository: PasswordRepository) {
        self.passwordRepository = passwordRepository
    }
    
    @Published
    var visible: Bool = true
    
    @Published
    var error: String? = nil
    
    /* Current password */
    
    @Published
    var currentPassword: PasswordDto? = nil
    
    func getPassword(_ id: UUID) {
        let result = passwordRepository.fetch(id: id)
        switch result {
        case .success(let data):
            currentPassword = data
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }
    
}
