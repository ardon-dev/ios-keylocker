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
            objectID: self.objectID
        )
    }
}

extension PasswordDto {
    func toEntity(context: NSManagedObjectContext) -> Password? {
        guard let objectID = self.objectID else { return nil }
        return context.object(with: objectID) as? Password
    }
}
