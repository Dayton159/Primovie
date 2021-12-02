//
//  MockFavoritesDataSource.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Primovie_Core
import Common
import RxSwift
import CoreData

public struct MockFavoritesDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = [CDMovieFavorite]

  private let _context: NSManagedObjectContext

  public init(context: NSManagedObjectContext) {
    _context = context
  }

  public func execute(request: Any?) -> Single<[CDMovieFavorite]> {
    return Single<[CDMovieFavorite]>.create { single in
      single(.success(CDMovieFavorite.createListSample(context: _context)))
      return Disposables.create()
    }
  }
}
