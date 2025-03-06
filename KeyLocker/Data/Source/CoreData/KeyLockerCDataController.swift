//
//  KeyLockerCDataManager.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//

import Foundation
import CoreData

struct KeyLockerCDataController {
    
    static let shared = KeyLockerCDataController()
    
    let container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "KeyLockerCData")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let nsError = error as NSError? {
                fatalError("Error loading CoreData: \(nsError), \(nsError.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func saveContext() throws {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw error
            }
        }
    }
    
}

