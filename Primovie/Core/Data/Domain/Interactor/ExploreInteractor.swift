//
//  ExploreInteractor.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import RxSwift

protocol ExploreUseCase: AnyObject {
  func getPopularMovies() -> Single<[MovieModel]>
  func getMovieLists(by keyword: String) -> Single<[MovieModel]>
}

class ExploreInteractor {
  private let repository: ExploreRepositoryProtocol

  init(repository: ExploreRepositoryProtocol) {
    self.repository = repository
  }
}

extension ExploreInteractor: ExploreUseCase {
  func getPopularMovies() -> Single<[MovieModel]> {
    repository.getPopularMovies()
      .map { MovieMapper.mapMovieEntityToDomain(movie: $0)}
  }

  func getMovieLists(by keyword: String) -> Single<[MovieModel]> {
    repository.getMovieLists(by: keyword)
      .map { MovieMapper.mapMovieEntityToDomain(movie: $0)}
  }
}
