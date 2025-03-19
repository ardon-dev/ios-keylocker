//
//  PasswordRepository.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//

import Foundation

protocol PasswordRepository {
    
    func insert(_ passwordDto: PasswordDto) -> Result<Bool, Error>
    
    func fetchAll() -> Result<[PasswordDto], Error>
    
    func remove(_ pasword: PasswordDto) -> Result<Bool, Error>
    
    func fetch(id: UUID) -> Result<PasswordDto?, Error>
    
    func update(_ password: PasswordDto) -> Result<Bool, Error>
    
}

