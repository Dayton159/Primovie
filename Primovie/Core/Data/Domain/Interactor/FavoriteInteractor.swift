//
//  FavoriteInteractor.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import RxSwift

protocol FavoriteUseCase: AnyObject {
  func getFavoriteMovies() -> Single<[MovieModel]>
}

class FavoriteInteractor {
  private let repository: FavoriteRepositoryProtocol

  init(repository: FavoriteRepositoryProtocol) {
    self.repository = repository
  }
}

extension FavoriteInteractor: FavoriteUseCase {
  func getFavoriteMovies() -> Single<[MovieModel]> {
    repository.getFavoriteMovies()
      .map { MovieMapper.mapMovieEntityToDomain(movie: $0)}
  }
}
