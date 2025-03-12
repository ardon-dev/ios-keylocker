//
//  Password+CoreDataProperties.swift
//  KeyLocker
//
//  Created by Josue on 11/3/25.
//
//

import Foundation
import CoreData


extension Password {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Password> {
        return NSFetchRequest<Password>(entityName: "Password")
    }

    @NSManaged public var alias: String?
    @NSManaged public var id: UUID?
    @NSManaged public var password: String?
    @NSManaged public var user: String?
    @NSManaged public var icon: String?
    @NSManaged public var lastUpdate: Date?

}

extension Password : Identifiable {

}
