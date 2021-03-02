//
//  CoreDataStack.swift
//  FRSeatGeek
//
//  Created by Lambda_School_Loaner_204 on 3/2/21.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var container: NSPersistentContainer =  {
        let container = NSPersistentContainer(name: "FRSeatGeek")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }

    func save(context: NSManagedObjectContext) throws {
        var error: Error?

        context.performAndWait {
            do {
                try context.save()
            } catch let saveError {
                error = saveError
            }
        }

        if let error = error { throw error }
    }
}
