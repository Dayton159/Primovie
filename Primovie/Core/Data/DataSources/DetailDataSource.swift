//
//  DetailDataSource.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import Foundation
import RxSwift

protocol DetailDataSourceProtocol: AnyObject {
  func getMovieDetail() -> Single<DetailMovieResponse>
}

class DetailDataSource: NSObject {
  typealias DetailDataSourceInstance = (DetailMovieRequest) -> DetailDataSource
  private let detail: DetailMovieRequest

  private init(detail: DetailMovieRequest) {
    self.detail = detail
  }

  static let sharedInstance: DetailDataSourceInstance = { detail in
    return DetailDataSource(
      detail: detail
    )
  }
}

extension DetailDataSource: DetailDataSourceProtocol {
  func getMovieDetail() -> Single<DetailMovieResponse> {
    return API()
      .fetch(detail)
  }
}
