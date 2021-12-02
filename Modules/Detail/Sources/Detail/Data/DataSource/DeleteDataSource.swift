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

public class DeleteDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = Void

  private let _request: DeleteMovieRequest
  private let _context: NSManagedObjectContext

  public init(request: DeleteMovieRequest, context: NSManagedObjectContext) {
    _request = request
    _context = context
  }

  public func execute(request: Any?) -> Single<Void> {
    return Single<Void>.create { single in
      self._context.performAndWait {
        let fetchRequest = self._request.makeFetchRequest()
        do {
          guard let result = try self._context.fetch(fetchRequest).first as? CDMovieFavorite else { return }
          self._context.delete(result)

          if self._context.hasChanges {
            try self._context.save()
            single(.success(()))
          }
        } catch let error {
          single(.failure(error))
        }
      }
      return Disposables.create()
    }
  }
}
