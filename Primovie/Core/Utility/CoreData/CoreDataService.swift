//
//  CoreDataService.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import RxSwift
import CoreData

protocol DatabaseService {
  func saveMovie(movie: MovieEntity, detail: DetailEntity) -> Single<Void>
  func getAllFavoriteMovies() -> Single<[MovieEntity]>
  func getDetailFavoriteMovie() -> Single<DetailEntity>
  func deleteFavoriteMovie() -> Single<Void>
  func isMovieFavorited() -> Single<Bool>
}

class CoreDataService: DatabaseService {
  private let context: NSManagedObjectContext
  private let request: CoreDataRequest

  init(
    context: NSManagedObjectContext = CoreDataStack.shared.context(),
    request: CoreDataRequest) {
    self.context = context
    self.request = request
  }

  func saveMovie(movie: MovieEntity, detail: DetailEntity) -> Single<Void> {
    return Single<Void>.create { single in
      self.context.performAndWait {
        if let favorite = self.request.makeEntityDescription(context: self.context) {
          let newFavorite = NSManagedObject(entity: favorite, insertInto: self.context)
          newFavorite.setValue(movie.idMovie, forKey: "idMovie")
          newFavorite.setValue(movie.title, forKey: "title")
          newFavorite.setValue(movie.overview, forKey: "overview")
          newFavorite.setValue(movie.releaseDate, forKey: "releaseDate")
          newFavorite.setValue(movie.popularity, forKey: "popularity")
          newFavorite.setValue(movie.rating, forKey: "rating")
          newFavorite.setValue(movie.backdropPath, forKey: "backdropPath")
          newFavorite.setValue(movie.posterPath, forKey: "posterPath")
          newFavorite.setValue(detail.genres, forKey: "genres")
          newFavorite.setValue(detail.tagline, forKey: "tagline")
          newFavorite.setValue(detail.status, forKey: "status")
          newFavorite.setValue(detail.runtime, forKey: "runtime")
          newFavorite.setValue(detail.language, forKey: "language")
        }
        if self.context.hasChanges {
          do {
            try self.context.save()
            single(.success(()))
          } catch let error {
            single(.failure(error))
          }
        }
      }
      return Disposables.create()
    }
  }

  func getAllFavoriteMovies() -> Single<[MovieEntity]> {
    return Single<[MovieEntity]>.create { single in
      self.context.perform {
        let fetchRequest = self.request.makeFetchRequest()
        do {
          guard let fetchedMovie = try self.context.fetch(fetchRequest) as? [MovieFavorite] else { return }
          single(.success(MovieMapper.mapMovieCDToEntity(object: fetchedMovie)))
        } catch let error {
          single(.failure(error))
        }
      }
      return Disposables.create()
    }
  }

  func getDetailFavoriteMovie() -> Single<DetailEntity> {
    return Single<DetailEntity>.create { single in
      self.context.perform {
        let fetchRequest = self.request.makeFetchRequest()
        do {
          guard let result = try self.context.fetch(fetchRequest).first as? MovieFavorite else { return }
          single(.success(MovieMapper.mapDetailCDToEntity(object: result)))
        } catch let error {
          single(.failure(error))
        }
      }
      return Disposables.create()
    }
  }

  func deleteFavoriteMovie() -> Single<Void> {
    return Single<Void>.create { single in
      self.context.performAndWait {
        let fetchRequest = self.request.makeFetchRequest()
        do {
          guard let result = try self.context.fetch(fetchRequest).first as? MovieFavorite else { return }
          self.context.delete(result)

          if self.context.hasChanges {
            try self.context.save()
            single(.success(()))
          }
        } catch let error {
          single(.failure(error))
        }
      }
      return Disposables.create()
    }
  }

  func isMovieFavorited() -> Single<Bool> {
    return Single<Bool>.create { single in
      self.context.perform {
        let fetchRequest = self.request.makeFetchRequest()
        do {
          if try self.context.fetch(fetchRequest).first != nil {
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
