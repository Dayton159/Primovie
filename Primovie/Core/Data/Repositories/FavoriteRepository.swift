//
//  FavoriteRepository.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import RxSwift

protocol FavoriteRepositoryProtocol: AnyObject {
  func getFavoriteMovies() -> Single<[MovieEntity]>
}

class FavoriteRepository {
  typealias FavoriteRepositoryInstance = (FavoriteDataSourceProtocol) -> FavoriteRepository
  let favoriteDataSource: FavoriteDataSourceProtocol

  private init(favoriteDataSource: FavoriteDataSourceProtocol) {
    self.favoriteDataSource = favoriteDataSource
  }

  static let sharedInstance: FavoriteRepositoryInstance = { favoriteDataSource in
    return FavoriteRepository(favoriteDataSource: favoriteDataSource)
  }
}

extension FavoriteRepository: FavoriteRepositoryProtocol {
  func getFavoriteMovies() -> Single<[MovieEntity]> {
    favoriteDataSource.getFavoriteMovies()
  }
}
