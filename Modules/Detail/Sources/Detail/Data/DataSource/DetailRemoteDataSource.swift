//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import Common
import RxSwift

public class DetailRemoteDataSource: DataSource {
  public typealias Request = Any
  public typealias Response = DetailMovieResponse

  private let _request: DetailRemoteRequest

  public init(request: DetailRemoteRequest) {
    _request = request
  }

  public func execute(request: Any?) -> Single<DetailMovieResponse> {
    API().fetch(_request)
  }
}
