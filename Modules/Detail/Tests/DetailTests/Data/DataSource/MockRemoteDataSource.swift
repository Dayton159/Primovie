//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import Common
import RxSwift

public class MockRemoteDataSource: DataSource {
  public typealias Request = Any
  public typealias Response = DetailMovieResponse

  public func execute(request: Any?) -> Single<DetailMovieResponse> {
    return Single<DetailMovieResponse>.create { single in
      single(.success(DetailMovieResponse.sample))
      return Disposables.create()
    }
  }
  public init() { }
}
