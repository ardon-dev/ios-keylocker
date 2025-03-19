//
//  PasswordModificationRepositoryImpl.swift
//  KeyLocker
//
//  Created by Josue on 17/3/25.
//

import Foundation
import CoreData

class PasswordModificationRepositoryImpl: PasswordModificationRepository {
    
    private var controller: KeyLockerCDataController
    
    init(controller: KeyLockerCDataController) {
        self.controller = controller
    }
    
    func insert(modificationDto: ModificationDto) -> Result<Bool, any Error> {
        do {
            let newModification = PasswordModification(context: self.controller.context)
            newModification.id = modificationDto.id
            newModification.password = modificationDto.password
            newModification.passwordId = modificationDto.passwordId
            newModification.modification_password = modificationDto.modificationPassword.toEntity(context: self.controller.context)
            newModification.date = modificationDto.date
            try self.controller.saveContext()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchAllByPassword(passwordId: UUID) -> Result<[ModificationDto], any Error> {
        do {
            let request: NSFetchRequest<PasswordModification> = PasswordModification.fetchRequest()
            request.predicate = NSPredicate(format: "passwordId == %@", passwordId.uuidString)
            let results = try controller.context.fetch(request)
            return .success(results.map { $0.toDto() })
        } catch {
            return .failure(error)
        }
    }
    
    func delete(_ modification: ModificationDto) -> Result<Bool, any Error> {
        do {
            let request: NSFetchRequest<PasswordModification> = PasswordModification.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", modification.id.uuidString)
            let results = try controller.context.fetch(request)
            if let entity = results.first {
                controller.context.delete(entity)
                try controller.saveContext()
                return .success(true)
            } else {
                return .failure(NSError(domain: "No modification found.", code: -1))
            }
        } catch {
            return .failure(error)
        }
    }
    
}
