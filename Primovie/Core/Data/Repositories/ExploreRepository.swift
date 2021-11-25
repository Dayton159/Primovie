//
//  ExploreRepository.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import RxSwift

protocol ExploreRepositoryProtocol: AnyObject {
  func getPopularMovies() -> Single<[MovieEntity]>
  func getMovieLists(by keyword: String) -> Single<[MovieEntity]>
}

class ExploreRepository {
  typealias ExploreRepositoryInstance = (ExploreDataSourceProtocol) -> ExploreRepository
  let exploreDataSource: ExploreDataSourceProtocol

  private init(exploreDataSource: ExploreDataSourceProtocol) {
    self.exploreDataSource = exploreDataSource
  }

  static let sharedInstance: ExploreRepositoryInstance = { exploreDataSource in
    return ExploreRepository(exploreDataSource: exploreDataSource)
  }
}

extension ExploreRepository: ExploreRepositoryProtocol {
  func getPopularMovies() -> Single<[MovieEntity]> {
    exploreDataSource.getPopularMovies()
      .map { MovieMapper.mapMovieResponsesToEntity(movie: $0)}
  }

  func getMovieLists(by keyword: String) -> Single<[MovieEntity]> {
    exploreDataSource.getMovieLists(by: keyword)
      .map { MovieMapper.mapMovieResponsesToEntity(movie: $0)}
  }
}
