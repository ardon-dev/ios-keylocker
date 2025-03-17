//
//  Password+CoreDataProperties.swift
//  KeyLocker
//
//  Created by Josue on 17/3/25.
//
//

import Foundation
import CoreData


extension Password {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Password> {
        return NSFetchRequest<Password>(entityName: "Password")
    }

    @NSManaged public var alias: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: UUID?
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var password: String?
    @NSManaged public var user: String?
    @NSManaged public var password_modifications: NSSet?

}

// MARK: Generated accessors for password_modifications
extension Password {

    @objc(addPassword_modificationsObject:)
    @NSManaged public func addToPassword_modifications(_ value: PasswordModification)

    @objc(removePassword_modificationsObject:)
    @NSManaged public func removeFromPassword_modifications(_ value: PasswordModification)

    @objc(addPassword_modifications:)
    @NSManaged public func addToPassword_modifications(_ values: NSSet)

    @objc(removePassword_modifications:)
    @NSManaged public func removeFromPassword_modifications(_ values: NSSet)

}

extension Password : Identifiable {

}
