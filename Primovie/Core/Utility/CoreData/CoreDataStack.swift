//
//  CoreDataStack.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import CoreData

class CoreDataStack {
  private init() {}
  static let shared = CoreDataStack()

  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Primovie")

    container.loadPersistentStores { (_, error) in
      guard let error = error as NSError? else { return }
      fatalError("Unresolved error: \(error), \(error.userInfo)")
    }

    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.undoManager = nil
    container.viewContext.shouldDeleteInaccessibleFaults = true
    container.viewContext.automaticallyMergesChangesFromParent = true

    return container
  }()
}

extension CoreDataStack {
    func context() -> NSManagedObjectContext {
      let taskContext = persistentContainer.newBackgroundContext()
      taskContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
      taskContext.undoManager = nil

      return taskContext
    }
}
