//
//  File.swift
//  
//
//  Created by Dayton on 30/11/21.
//

import Primovie_Core
import Common
import RxSwift
@testable import Home

public struct MockMovieListDataSource: DataSource {

  public typealias Request = MovieRequest
  public typealias Response = [MovieResponse]

  public func execute(request: MovieRequest?) -> Single<[MovieResponse]> {
    return Single<[MovieResponse]>.create { single in
      single(.success(MovieResponse.samples))
      return Disposables.create()
    }
  }

  public init() { }
}
