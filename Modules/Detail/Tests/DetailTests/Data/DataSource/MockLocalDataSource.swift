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

public struct MockLocalDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = CDMovieFavorite

  private let _context: NSManagedObjectContext

  public init(context: NSManagedObjectContext) {
    _context = context
  }

  public func execute(request: Any?) -> Single<CDMovieFavorite> {
    return Single<CDMovieFavorite>.create { single in
      single(.success(CDMovieFavorite.createDetailSample(context: _context)))
      return Disposables.create()
    }
  }
}
