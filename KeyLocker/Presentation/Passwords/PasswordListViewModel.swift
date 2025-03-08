//
//  PasswordListViewModel.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//

import Foundation

class PasswordListViewModel: ObservableObject {
    
    private var passwordRepository: PasswordRepository
    
    init(passwordRepository: PasswordRepository) {
        self.passwordRepository = passwordRepository
    }
    
    /* Password list */
    
    @Published
    var passwords: [PasswordDto] = []
    
    @Published
    var query: String = ""
    
    func getPasswords() {
        let result = passwordRepository.fetchAll()
        switch result {
        case .success(let data):
            print(passwords)
            passwords = data
        case .failure(let error):
            print(error)
        }
    }
    
    func removePassword(_ password: PasswordDto) {
        let result = passwordRepository.remove(password)
        switch result {
        case .success(let data):
            print("Removed \(data)")
        case .failure(let error):
            print(error)
        }
    }
    
}
