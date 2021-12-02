//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import Common
import RxSwift
import CoreData

public struct MockIsFavoritedDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = Bool

  public var _isFavExp = true

  public init() { }

  public func execute(request: Any?) -> Single<Bool> {
    return Single<Bool>.create { single in
      single(.success(_isFavExp))
      return Disposables.create()
    }
  }
}
