//
//  PasswordModification+CoreDataProperties.swift
//  KeyLocker
//
//  Created by Josue on 17/3/25.
//
//

import Foundation
import CoreData


extension PasswordModification {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PasswordModification> {
        return NSFetchRequest<PasswordModification>(entityName: "PasswordModification")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var password: String?
    @NSManaged public var passwordId: UUID?
    @NSManaged public var modification_password: Password?

}

extension PasswordModification : Identifiable {

}
