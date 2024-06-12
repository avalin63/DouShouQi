//
//  DataManager.swift
//  DouShouQi
//
//  Created by Lucas Delanier on 12/06/2024.
//

import Foundation

import CoreData

class DataManager {
    static let shared = DataManager()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Data stack: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
