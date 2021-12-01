//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import CoreData

public class MockCoreDataStack: CoreDataStack {
  public override init() {
    super.init()

    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType

    let container = NSPersistentContainer(
      name: CoreDataStack.name,
      managedObjectModel: model)
    container.persistentStoreDescriptions = [persistentStoreDescription]

    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }

    persistentContainer = container
  }
}
