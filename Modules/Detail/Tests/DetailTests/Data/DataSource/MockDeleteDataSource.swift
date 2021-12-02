//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import RxSwift

public struct MockDeleteDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = Void

  public init() { }

  public func execute(request: Any?) -> Single<Void> {
    return Single<Void>.create { single in
      single(.success(()))
      return Disposables.create()
    }
  }
}
