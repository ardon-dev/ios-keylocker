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
            let entity = password.toEntity(context: controller.context)
            controller.context.delete(entity)
            try controller.context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
}
