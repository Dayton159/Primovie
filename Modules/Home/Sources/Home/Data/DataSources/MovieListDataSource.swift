//
//  MovieListDataSource.swift
//  
//
//  Created by Dayton on 29/11/21.
//

import Primovie_Core
import Common
import RxSwift

public class MovieListDataSource: DataSource {

  public typealias Request = MovieRequest
  public typealias Response = [MovieResponse]

  private var _request: HomeMovieRequest

  public init(request: HomeMovieRequest) {
    self._request = request
  }

  public func execute(request: MovieRequest?) -> Single<[MovieResponse]> {
    self._request.path = request
    return API().fetch(_request).map { $0.results }
  }

  public func getGenre() -> Single<[Genre]> {
    let request = GenreMovieRequest()
    return API().fetch(request).map { $0.genres }
  }
}
