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
        return PasswordDto(id: self.id ?? UUID(), alias: self.alias ?? "", password: self.password ?? "")
    }
}

extension PasswordDto {
    func toEntity(context: NSManagedObjectContext) -> Password {
        let p = Password(context: context)
        p.id = self.id
        p.alias = self.alias
        p.password = self.password
        return p
    }
}
