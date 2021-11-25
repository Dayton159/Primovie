//
//  ExploreDataSource.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import Foundation
import RxSwift

protocol ExploreDataSourceProtocol: AnyObject {
  func getPopularMovies() -> Single<[MovieResponse]>
  func getMovieLists(by keyword: String) -> Single<[MovieResponse]>
}

class ExploreDataSource: NSObject {
  typealias ExploreDataSourceInstance = (PopularMovieRequest, SearchMovieRequest) -> ExploreDataSource
  private let popular: PopularMovieRequest
  private var search: SearchMovieRequest

  private init(popular: PopularMovieRequest, search: SearchMovieRequest) {
    self.popular = popular
    self.search = search
  }

  static let sharedInstance: ExploreDataSourceInstance = { popular, search in
    return ExploreDataSource(
      popular: popular,
      search: search
    )
  }
}

extension ExploreDataSource: ExploreDataSourceProtocol {
  func getPopularMovies() -> Single<[MovieResponse]> {
    return API()
      .fetch(popular)
      .map { $0.results }
  }

  func getMovieLists(by keyword: String) -> Single<[MovieResponse]> {
    self.search.searchQuery = keyword
    return API()
      .fetch(search)
      .map { $0.results }
  }
}
