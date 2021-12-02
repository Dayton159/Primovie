//
//  Injection.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

import Foundation
import Primovie_Core
import Home
import Explore
import Favorite
import Common
import Detail

final class Injection: NSObject {
  // MARK: - Modularization
  func provideHome<U: UseCase>() -> U where U.Request == MovieRequest, U.Response == [MovieModel] {
    let request = HomeMovieRequest()
    let remote = MovieListDataSource(request: request)
    let mapper = HomeMapper()
    let repository = HomeRepository(remote: remote, mapper: mapper)

    guard let interactor = Interactor(repository: repository) as? U
    else { fatalError("Failed to cast Interactor \(String(describing: U.self))")}

    return interactor
  }

  func provideExplore<U: UseCase>() -> U where U.Request == String, U.Response == [MovieModel] {
    let popularRequest = PopularMovieRequest()
    let searchRequest = SearchMovieRequest()
    let remote = ExploreDataSource(popular: popularRequest, search: searchRequest)
    let mapper = ExploreMapper()
    let repository = ExploreRepository(remote: remote, mapper: mapper)

    guard let interactor = Interactor(repository: repository) as? U
    else { fatalError("Failed to cast Interactor \(String(describing: U.self))")}

    return interactor
  }

  func provideFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == [MovieModel] {
    let request = FavoritesRequest()
    let locale = FavoritesDataSource(context: CoreDataStack.shared.context(), request: request)
    let mapper = FavoritesMapper()
    let repository = FavoritesRepository(remote: locale, mapper: mapper)

    guard let interactor = Interactor(repository: repository) as? U
    else { fatalError("Failed to cast Interactor \(String(describing: U.self))")}

    return interactor
  }

  func provideDetail<U: UseCase>(id: Int, model: MovieModel) -> U where U.Request == DataRequestSource, U.Response == DetailModel {
    let remoteRequest = DetailRemoteRequest(movieID: id)
    let localeRequest = DetailLocalRequest(id: id)

    let remote = DetailRemoteDataSource(request: remoteRequest)
    let locale = DetailLocalDataSource(context: CoreDataStack.shared.context(), request: localeRequest)

    let remoteMapper = RemoteMapper()
    let localeMapper = LocalMapper()

    let repository = DetailMovieRepository(remote: remote, local: locale, mapperRemote: remoteMapper, mapperLocal: localeMapper, model: model)

    guard let interactor = Interactor(repository: repository) as? U
    else { fatalError("Failed to cast Interactor \(String(describing: U.self))")}

    return interactor
  }

  func provideSave<U: UseCase>() -> U where U.Request == DetailModel, U.Response == Void {
    let request = SaveMovieRequest()
    let local = SaveDataSource(request: request, context: CoreDataStack.shared.context())
    let mapper = SaveMapper()
    let repository = SaveMovieRepository(local: local, mapper: mapper)

    guard let interactor = Interactor(repository: repository) as? U
    else { fatalError("Failed to cast Interactor \(String(describing: U.self))")}

    return interactor
  }

  func provideDelete<U: UseCase>(id: Int) -> U where U.Request == Any, U.Response == Void {
    let request = DeleteMovieRequest(id: id)
    let local = DeleteDataSource(request: request, context: CoreDataStack.shared.context())
    let repository = DeleteMovieRepository(local: local)

    guard let interactor = Interactor(repository: repository) as? U
    else { fatalError("Failed to cast Interactor \(String(describing: U.self))")}

    return interactor
  }

  func provideIsFavorite<U: UseCase>(id: Int) -> U where U.Request == Any, U.Response == Bool {
    let request = IsFavoritedRequest(id: id)
    let local = IsFavoritedDataSource(request: request, context: CoreDataStack.shared.context())
    let repository = IsFavoriteMovieRepository(local: local)

    guard let interactor = Interactor(repository: repository) as? U
    else { fatalError("Failed to cast Interactor \(String(describing: U.self))")}

    return interactor
  }
}
