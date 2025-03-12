//
//  Password.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//

import Foundation
import CoreData

struct PasswordDto: Identifiable {
    var id = UUID()
    var alias: String
    var password: String
    var user: String
    var icon: String
    var lastUpdate: Date
    var objectID: NSManagedObjectID?
    
    init(id: UUID = UUID(), alias: String, password: String, user: String, icon: String, lastUpdate: Date, objectID: NSManagedObjectID? = nil) {
        self.id = id
        self.alias = alias
        self.password = password
        self.user = user
        self.icon = icon
        self.lastUpdate = lastUpdate
        self.objectID = objectID
    }
    
    init() {
        self.id = UUID()
        self.alias = ""
        self.password = ""
        self.user = ""
        self.icon = ""
        self.lastUpdate = Date.now
    }
    
}

extension PasswordDto {
    init(from entity: Password) {
        self.id = entity.id ?? UUID()
        self.alias = entity.alias ?? ""
        self.password = entity.password ?? ""
        self.user = entity.user ?? ""
        self.icon = entity.icon ?? ""
        self.lastUpdate = entity.lastUpdate ?? Date()
        self.objectID = entity.objectID // Asigna el objectID
    }
}
