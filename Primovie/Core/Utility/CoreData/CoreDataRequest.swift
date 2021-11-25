//
//  CoreDataRequest.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import CoreData

protocol CoreDataRequest {
  var entityName: String { get }
  var fetchLimit: Int { get }
  var predicate: NSPredicate? { get }
}

extension CoreDataRequest {
  var entityName: String { "CDMovieFavorite"}
  var fetchLimit: Int { 1 }
  var predicate: NSPredicate? { nil }
}

extension CoreDataRequest {
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
