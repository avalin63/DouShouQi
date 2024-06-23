//
//  UserVM.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 22/06/2024.
//

import Foundation
import DouShouQiModel
import CoreData
import UIKit

class UserVM: ObservableObject {
    @Published var savedUsers: [UserEntity] = []
    @Published var users: [User] = []
    
    init(){
        loadSavedPlayers()
    }
    
    private let dataManager = DataManager.shared
    
    func loadSavedPlayers() {
        let context = dataManager.context
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            self.savedUsers = try context.fetch(fetchRequest)
            self.users = self.savedUsers.map { entity in
                User(
                    id: entity.id ?? UUID(),
                    image: entity.picture?.imageFromBase64,
                    name: entity.username ?? ""
                )
            }
        } catch {
            print("Failed to fetch saved users: \(error)")
        }
    }
    
    
    func saveCurrentUser(id: UUID, username: String, picture: UIImage?) {
        let context = dataManager.context
        let newUser = UserEntity(context: context)
        newUser.id = id
        newUser.username = username
        newUser.picture = picture?.base64
        dataManager.saveContext()
        loadSavedPlayers()
    }
    
    func deleteAllUsers() {
        let context = dataManager.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = UserEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            dataManager.saveContext()
            loadSavedPlayers()
        } catch {
            print("Failed to delete all users: \(error)")
        }
    }
    
    func deleteUser(by id: UUID) {
        let context = dataManager.context
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            if let userToDelete = try context.fetch(fetchRequest).first {
                context.delete(userToDelete)
                dataManager.saveContext()
                loadSavedPlayers()
            } else {
                print("User with ID \(id) not found.")
            }
        } catch {
            print("Failed to delete user with ID \(id): \(error)")
        }
    }
    
    func getUser(by id: UUID) -> User? {
        let context = dataManager.context
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            if let userEntity = try context.fetch(fetchRequest).first {
                return User(
                    id: userEntity.id ?? UUID(),
                    image: userEntity.picture?.imageFromBase64,
                    name: userEntity.username ?? ""
                )
            } else {
                print("User with ID \(id) not found.")
                return nil
            }
        } catch {
            print("Failed to fetch user with ID \(id): \(error)")
            return nil
        }
    }
    
}
