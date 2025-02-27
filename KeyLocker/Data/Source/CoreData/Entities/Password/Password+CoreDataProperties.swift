//
//  Password+CoreDataProperties.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//
//

import Foundation
import CoreData


extension Password {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Password> {
        return NSFetchRequest<Password>(entityName: "Password")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var alias: String?
    @NSManaged public var password: String?

}

extension Password : Identifiable {

}
