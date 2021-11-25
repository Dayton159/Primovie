//
//  IsFavoritedRequest.swift
//  Primovie
//
//  Created by Dayton on 10/11/21.
//

import Foundation

struct IsFavoritedRequest: CoreDataRequest {
  var id: Int
  var predicate: NSPredicate? {
    NSPredicate(format: "idMovie == \(id)")
  }
}
