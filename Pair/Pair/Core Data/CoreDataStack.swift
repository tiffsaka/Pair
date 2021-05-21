//
//  CoreDataStack.swift
//  Pair
//
//  Created by Tiffany Sakaguchi on 5/21/21.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Pair")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading persistent stores \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { container.viewContext }
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        }
    }
}//End of enum
