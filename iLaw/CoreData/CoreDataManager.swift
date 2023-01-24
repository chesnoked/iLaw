//
//  CoreDataManager.swift
//  iLaw
//
//  Created by Evgeniy Safin on 24.01.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared: CoreDataManager = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "MyContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading from Core Data : \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving to Core Data : \(error.localizedDescription)")
        }
    }
}
