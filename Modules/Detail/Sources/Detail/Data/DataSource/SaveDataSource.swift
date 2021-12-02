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

public class SaveDataSource: LocaleDataSource {
  public typealias Request = (movie: MovieEntity, detail: DetailEntity)
  public typealias Response = Void

  private let _request: SaveMovieRequest
  private let _context: NSManagedObjectContext

  public init(request: SaveMovieRequest, context: NSManagedObjectContext) {
    _request = request
    _context = context
  }

  public func execute(request: (movie: MovieEntity, detail: DetailEntity)?) -> Single<Void> {
    return Single<Void>.create { single in
      self._context.performAndWait {
        if let favorite = self._request.makeEntityDescription(context: self._context) {
          let newFavorite = NSManagedObject(entity: favorite, insertInto: self._context)
          newFavorite.setValue(request?.movie.idMovie, forKey: "idMovie")
          newFavorite.setValue(request?.movie.title, forKey: "title")
          newFavorite.setValue(request?.movie.overview, forKey: "overview")
          newFavorite.setValue(request?.movie.releaseDate, forKey: "releaseDate")
          newFavorite.setValue(request?.movie.popularity, forKey: "popularity")
          newFavorite.setValue(request?.movie.rating, forKey: "rating")
          newFavorite.setValue(request?.movie.backdropPath, forKey: "backdropPath")
          newFavorite.setValue(request?.movie.posterPath, forKey: "posterPath")
          newFavorite.setValue(request?.detail.genres, forKey: "genres")
          newFavorite.setValue(request?.detail.tagline, forKey: "tagline")
          newFavorite.setValue(request?.detail.status, forKey: "status")
          newFavorite.setValue(request?.detail.runtime, forKey: "runtime")
          newFavorite.setValue(request?.detail.language, forKey: "language")
        }
        if self._context.hasChanges {
          do {
            try self._context.save()
            single(.success(()))
          } catch let error {
            single(.failure(error))
          }
        }
      }
      return Disposables.create()
    }
  }
}
