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

public class DetailLocalDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = CDMovieFavorite

  private let _context: NSManagedObjectContext
  private let _request: DetailLocalRequest

  public init(context: NSManagedObjectContext, request: DetailLocalRequest) {
    _context = context
    _request = request
  }

  public func execute(request: Any?) -> Single<CDMovieFavorite> {
    return Single<CDMovieFavorite>.create { single in
      self._context.perform {
        let fetchRequest = self._request.makeFetchRequest()
        do {
          guard let result = try self._context.fetch(fetchRequest).first as? CDMovieFavorite else { return }
          single(.success(result))
        } catch let error {
          single(.failure(error))
        }
      }
      return Disposables.create()
    }
  }
}
