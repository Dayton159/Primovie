//
//  CoreDataRequest.swift
//  
//
//  Created by Dayton on 29/11/21.
//

import CoreData

public protocol CoreDataRequest {
  var entityName: String { get }
  var fetchLimit: Int { get }
  var predicate: NSPredicate? { get }
}

public extension CoreDataRequest {
  var entityName: String { "CDMovieFavorite"}
  var fetchLimit: Int { 1 }
  var predicate: NSPredicate? { nil }
}

public extension CoreDataRequest {
  func makeFetchRequest() -> NSFetchRequest<NSManagedObject> {
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
    if let predicate = predicate {
      fetchRequest.predicate = predicate
      fetchRequest.fetchLimit = fetchLimit
    }
    return fetchRequest
  }

  func makeEntityDescription(context: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName, in: context)
  }
}
