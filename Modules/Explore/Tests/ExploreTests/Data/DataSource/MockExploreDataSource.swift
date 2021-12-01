//
//  MockExploreDataSource.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Primovie_Core
import Common
import RxSwift

public struct MockExploreDataSource: DataSource {
  public typealias Request = String
  public typealias Response = [MovieResponse]

  public func execute(request: String?) -> Single<[MovieResponse]> {
    return Single<[MovieResponse]>.create { single in
      single(.success(MovieResponse.samples))
      return Disposables.create()
    }
  }

  public init() { }
}
