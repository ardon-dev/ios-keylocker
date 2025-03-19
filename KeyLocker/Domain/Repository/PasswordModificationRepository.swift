//
//  PasswordModificationRepository.swift
//  KeyLocker
//
//  Created by Josue on 17/3/25.
//

import Foundation

protocol PasswordModificationRepository {
    
    func insert(modificationDto: ModificationDto) -> Result<Bool, Error>
    
    func fetchAllByPassword(passwordId: UUID) -> Result<[ModificationDto], Error>
    
    func delete(_ modification: ModificationDto) -> Result<Bool, Error>
    
}
