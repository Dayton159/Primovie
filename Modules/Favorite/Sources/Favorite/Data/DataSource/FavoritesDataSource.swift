//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Primovie_Core
import Common
import RxSwift
import CoreData

public class FavoritesDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = [CDMovieFavorite]

  private let _context: NSManagedObjectContext
  private let _request: FavoritesRequest

  public init(context: NSManagedObjectContext, request: FavoritesRequest) {
    _context = context
    _request = request
  }

  public func execute(request: Any?) -> Single<[CDMovieFavorite]> {
    return Single<[CDMovieFavorite]>.create { single in
      self._context.perform {
        let fetchRequest = self._request.makeFetchRequest()
        do {
          guard let fetchedMovie = try self._context.fetch(fetchRequest) as? [CDMovieFavorite] else { return }
          single(.success(fetchedMovie))
        } catch let error {
          single(.failure(error))
        }
      }
      return Disposables.create()
    }
  }
}
