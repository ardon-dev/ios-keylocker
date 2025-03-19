//
//  ModificationDto.swift
//  KeyLocker
//
//  Created by Josue on 17/3/25.
//

import Foundation
import CoreData

struct ModificationDto: Identifiable {
    var id = UUID()
    var date: Date
    var password: String
    var passwordId: UUID
    var modificationPassword: PasswordDto
    var objectID: NSManagedObjectID?
    
    init(
        id: UUID = UUID(),
        date: Date,
        password: String,
        passwordId: UUID,
        modificationPassword: PasswordDto,
        objectID: NSManagedObjectID? = nil
    ) {
        self.id = id
        self.date = date
        self.password = password
        self.passwordId = passwordId
        self.modificationPassword = modificationPassword
        self.objectID = objectID
    }
    
    init() {
        self.id = UUID()
        self.date = Date()
        self.password = "Default"
        self.passwordId = UUID()
        self.modificationPassword = PasswordDto()
    }
}

extension ModificationDto {
    init(from entity: PasswordModification) {
        self.id = entity.id ?? UUID()
        self.date = entity.date ?? Date()
        self.password = entity.password ?? ""
        self.passwordId = entity.passwordId ?? UUID()
        self.modificationPassword = entity.modification_password?.toDto() ?? PasswordDto()
        self.objectID = entity.objectID
    }
}

