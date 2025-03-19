//
//  PasswordRepositoryImpl.swift
//  KeyLocker
//
//  Created by Josue on 27/2/25.
//

import Foundation
import CoreData

class PasswordRepositoryImpl: PasswordRepository {

    private var controller: KeyLockerCDataController
    
    init(controller: KeyLockerCDataController) {
        self.controller = controller
    }
    
    func insert(_ passwordDto: PasswordDto) -> Result<Bool, any Error> {
        do {
            let newPassword = Password(context: self.controller.context)
            newPassword.id = passwordDto.id
            newPassword.alias = passwordDto.alias
            newPassword.password = passwordDto.password
            newPassword.user = passwordDto.user
            newPassword.icon = passwordDto.icon
            newPassword.lastUpdate = passwordDto.lastUpdate
            try self.controller.saveContext()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchAll() -> Result<[PasswordDto], any Error> {
        do {
            let request: NSFetchRequest<Password> = Password.fetchRequest()
            let items = try controller.context.fetch(request)
            return .success(items.map { element in element.toDto()})
        } catch {
            return .failure(error)
        }
    }
    
    func remove(_ password: PasswordDto) -> Result<Bool, any Error> {
        do {
            guard let entity = password.toEntity(context: controller.context) else {
                return .failure(
                    NSError(domain: "InvalidEntity", code: -1, userInfo: nil)
                )
            }
            controller.context.delete(entity)
            try controller.saveContext()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func fetch(id: UUID) -> Result<PasswordDto?, any Error> {
        do {
            let request: NSFetchRequest<Password> = Password.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id.uuidString)
            request.fetchLimit = 1
            let results = try controller.context.fetch(request)
            return .success(results.first.map { element in element.toDto() })
        } catch {
            return .failure(error)
        }
    }
    
    func update(_ password: PasswordDto) -> Result<Bool, any Error> {
        do {
            let request: NSFetchRequest<Password> = Password.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", password.id.uuidString)
            let results = try controller.context.fetch(request)
            if let passwordToUpdate = results.first {
                passwordToUpdate.alias = password.alias
                passwordToUpdate.user = password.user
                passwordToUpdate.icon = password.icon
                passwordToUpdate.password = password.password
                passwordToUpdate.lastUpdate = password.lastUpdate
                try controller.context.save()
                return .success(true)
            } else {
                return .failure(NSError(domain: "No password found.", code: 1))
            }
        } catch {
            return .failure(error)
        }
    }
    
}
