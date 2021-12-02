//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Common
import Foundation

public struct DeleteMovieRequest: CoreDataRequest {
  public var id: Int
  public var predicate: NSPredicate? {
    NSPredicate(format: "idMovie == \(id)")
  }

  public init(id: Int) {
    self.id = id
  }
}
