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
    
    var filteredPasswords: [PasswordDto]  {
        if query.isEmpty {
            return passwords
        } else {
            return passwords.filter{
                $0.alias.localizedCaseInsensitiveContains(query)
            }
        }
    }
    
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
    
    func removePassword(at indexSet: IndexSet) {
        for index in indexSet {
            let password = filteredPasswords[index]
            let result = passwordRepository.remove(password)
            switch result {
            case .success(let data):
                print("Removed \(data)")
                query = ""
                passwords.remove(at: index)
            case .failure(let error):
                print(error)
            }
        }
       
       
    }
    
}
