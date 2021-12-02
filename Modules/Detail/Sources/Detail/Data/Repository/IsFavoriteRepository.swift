//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import RxSwift

public struct IsFavoriteRepository<
  IsFavoriteDataSource: LocaleDataSource>: Repository
where IsFavoriteDataSource.Request == Any,
      IsFavoriteDataSource.Response == Bool {

  public typealias Request = Any
  public typealias Response = Bool

  private let _dataSource: IsFavoriteDataSource

  public init(local: IsFavoriteDataSource) {
    _dataSource = local
  }

  public func execute(request: Any?) -> Single<Bool> {
    _dataSource.execute(request: request)
  }
}
