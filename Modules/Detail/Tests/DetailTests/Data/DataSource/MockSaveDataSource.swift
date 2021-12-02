//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import Common
import RxSwift

public struct MockSaveDataSource: LocaleDataSource {
  public typealias Request = (movie: MovieEntity, detail: DetailEntity)
  public typealias Response = Void

  public init() { }

  public func execute(request: (movie: MovieEntity, detail: DetailEntity)?) -> Single<Void> {
    return Single<Void>.create { single in
      single(.success(()))
      return Disposables.create()
    }
  }
}
