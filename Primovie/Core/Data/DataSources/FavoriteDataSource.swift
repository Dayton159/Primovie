//
//  FavoriteDataSource.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import Foundation
import RxSwift

protocol FavoriteDataSourceProtocol: AnyObject {
  func getFavoriteMovies() -> Single<[MovieEntity]>
}

class FavoriteDataSource: NSObject {
  typealias FavoriteDataSourceInstance = (FavoriteRequest) -> FavoriteDataSource
  private let favorite: FavoriteRequest

  private init(favorite: FavoriteRequest) {
    self.favorite = favorite
  }

  static let sharedInstance: FavoriteDataSourceInstance = { favorite in
    return FavoriteDataSource(
      favorite: favorite
    )
  }
}

extension FavoriteDataSource: FavoriteDataSourceProtocol {
  func getFavoriteMovies() -> Single<[MovieEntity]> {
    CoreDataService(request: favorite)
      .getAllFavoriteMovies()
  }
}
