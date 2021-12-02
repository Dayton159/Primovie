//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import CoreData

public class CoreDataStack {
  public init() {}
  public static let shared = CoreDataStack()
  public static let name = "Primovie"

  public let model: NSManagedObjectModel = {
    guard let modelURL = Bundle.module.url(forResource: CoreDataStack.name, withExtension: "momd"),
          let model = NSManagedObjectModel(contentsOf: modelURL)
    else { fatalError("Cannot Find Core Data Model") }
    return model
  }()

  public lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: CoreDataStack.name, managedObjectModel: model)

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

public extension CoreDataStack {
  func context() -> NSManagedObjectContext {
    let taskContext = persistentContainer.newBackgroundContext()
    taskContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    taskContext.undoManager = nil

    return taskContext
  }
}
