//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Primovie_Core
import Common
import RxSwift

public class ExploreDataSource: DataSource {

  public typealias Request = String
  public typealias Response = [MovieResponse]

  private let _popular: PopularMovieRequest
  private var _search: SearchMovieRequest

  public init(popular: PopularMovieRequest, search: SearchMovieRequest) {
    self._popular = popular
    self._search = search
  }

  public func execute(request: String?) -> Single<[MovieResponse]> {
    self._search.searchQuery = request
    if request?.isEmpty ?? true {
     return API().fetch(_popular)
        .map { $0.results }
    } else {
     return API().fetch(_search)
        .map { $0.results }
    }
  }
}
