//
//  DeleteMovieRequest.swift
//  Primovie
//
//  Created by Dayton on 10/11/21.
//

import Foundation

struct DeleteMovieRequest: CoreDataRequest {
  var id: Int
  var predicate: NSPredicate? {
    NSPredicate(format: "idMovie == \(id)")
  }
}
