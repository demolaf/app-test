//
//  DataController.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation
import CoreData

class DataController {
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var backgroundContext: NSManagedObjectContext!

    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }

    func configureContexts() {
        backgroundContext = persistentContainer.newBackgroundContext()

        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true

        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }

    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { _, error in
            guard error == nil else { fatalError(error!.localizedDescription) }

            // self.autosaveViewContext()
            self.configureContexts()
            completion?()
        }
    }
}

extension DataController {
    func autosaveViewContext(interval: TimeInterval = 30) {
        print("autosaving")
        guard interval > 0 else {
            print("cannot set negative autosave interval")
            return
        }

        if viewContext.hasChanges {
            try? viewContext.save()
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + interval) {
            self.autosaveViewContext(interval: interval)
        }
    }
}
