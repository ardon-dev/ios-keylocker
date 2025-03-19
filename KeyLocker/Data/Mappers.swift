//
//  Mappers.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//

import Foundation
import CoreData

extension Password {
    func toDto() -> PasswordDto {
        return PasswordDto(
            id: self.id ?? UUID(),
            alias: self.alias ?? "",
            password: self.password ?? "",
            user: self.user ?? "",
            icon: self.icon ?? "",
            lastUpdate: self.lastUpdate ?? Date.now,
            objectID: self.objectID,
            modifications: []
        )
    }
}

extension PasswordDto {
    func toEntity(context: NSManagedObjectContext) -> Password? {
        guard let objectID = self.objectID else { return nil }
        return context.object(with: objectID) as? Password
    }
}

extension PasswordModification {
    func toDto() -> ModificationDto {
        return ModificationDto(
            id: self.id ?? UUID(),
            date: self.date ?? Date.now,
            password: self.password ?? "",
            passwordId: self.passwordId ?? UUID(),
            modificationPassword: self.modification_password?.toDto() ?? PasswordDto(),
            objectID: self.objectID
        )
    }
}

extension ModificationDto {
    func toEntity(context: NSManagedObjectContext) -> PasswordModification? {
        guard let objectID = self.objectID else { return nil }
        return context.object(with: objectID) as? PasswordModification
    }
}
