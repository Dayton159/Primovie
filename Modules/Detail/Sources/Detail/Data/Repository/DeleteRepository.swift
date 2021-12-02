//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import RxSwift

public struct DeleteRepository<
  DeleteDataSource: LocaleDataSource>: Repository
where DeleteDataSource.Request == Any,
      DeleteDataSource.Response == Void {
  public typealias Request = Any
  public typealias Response = Void

  private let _dataSource: DeleteDataSource

  public init(local: DeleteDataSource) {
    _dataSource = local
  }

  public func execute(request: Any?) -> Single<Void> {
    _dataSource.execute(request: request)
  }
}
