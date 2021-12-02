//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import RxSwift
import CoreData

public class IsFavoritedDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = Bool

  private let _request: IsFavoritedRequest
  private let _context: NSManagedObjectContext

  public init(request: IsFavoritedRequest, context: NSManagedObjectContext) {
    _request = request
    _context = context
  }

  public func execute(request: Any?) -> Single<Bool> {
    return Single<Bool>.create { single in
      self._context.perform {
        let fetchRequest = self._request.makeFetchRequest()
        do {
          if try self._context.fetch(fetchRequest).first != nil {
            single(.success(true))
          } else {
            single(.success(false))
          }
        } catch {
          single(.failure(error))
        }
      }
      return Disposables.create()
    }
  }
}
