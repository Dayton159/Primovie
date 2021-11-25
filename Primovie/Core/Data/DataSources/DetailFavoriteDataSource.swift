//
//  DetailFavoriteDataSource.swift
//  Primovie
//
//  Created by Dayton on 10/11/21.
//

import Foundation
import RxSwift

protocol DetailFavoriteDataSourceProtocol: AnyObject {
  func saveMovieToFavorite(movie: MovieEntity, detail: DetailEntity) -> Single<Void>
  func getDetailFavoriteMovie() -> Single<DetailEntity>
  func deleteFavoriteMovie() -> Single<Void>
  func isMovieFavorited() -> Single<Bool>
}

class DetailFavoriteDataSource: NSObject {
  typealias DetailFavoriteDataSourceInstance = (IsFavoritedRequest, SaveMovieRequest, DeleteMovieRequest, DetailFavoriteRequest) -> DetailFavoriteDataSource
  private let isFavoritedRequest: IsFavoritedRequest
  private let saveMovieRequest: SaveMovieRequest
  private let deleteMovieRequest: DeleteMovieRequest
  private let detailFavoriteRequest: DetailFavoriteRequest

  private init(
    isFavoritedRequest: IsFavoritedRequest,
    saveMovieRequest: SaveMovieRequest,
    deleteMovieRequest: DeleteMovieRequest,
    detailFavoriteRequest: DetailFavoriteRequest) {
    self.isFavoritedRequest = isFavoritedRequest
    self.saveMovieRequest = saveMovieRequest
    self.deleteMovieRequest = deleteMovieRequest
    self.detailFavoriteRequest = detailFavoriteRequest
  }

  static let sharedInstance: DetailFavoriteDataSourceInstance = { isFavoritedRequest, saveMovieRequest, deleteMovieRequest, detailFavoriteRequest in
    return DetailFavoriteDataSource(
      isFavoritedRequest: isFavoritedRequest,
      saveMovieRequest: saveMovieRequest,
      deleteMovieRequest: deleteMovieRequest,
      detailFavoriteRequest: detailFavoriteRequest
    )
  }
}

extension DetailFavoriteDataSource: DetailFavoriteDataSourceProtocol {
  func saveMovieToFavorite(movie: MovieEntity, detail: DetailEntity) -> Single<Void> {
    CoreDataService(request: saveMovieRequest)
      .saveMovie(movie: movie, detail: detail)
  }

  func getDetailFavoriteMovie() -> Single<DetailEntity> {
    CoreDataService(request: detailFavoriteRequest)
      .getDetailFavoriteMovie()
  }

  func deleteFavoriteMovie() -> Single<Void> {
    CoreDataService(request: deleteMovieRequest)
      .deleteFavoriteMovie()
  }

  func isMovieFavorited() -> Single<Bool> {
    CoreDataService(request: isFavoritedRequest)
      .isMovieFavorited()
  }
}
