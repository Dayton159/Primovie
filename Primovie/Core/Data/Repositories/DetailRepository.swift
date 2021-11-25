//
//  DetailRepository.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import RxSwift

protocol DetailRepositoryProtocol: AnyObject {
  func getMovieDetail(source: DataRequestSource) -> Single<DetailEntity>
  func saveMovieToFavorite(movie: MovieEntity, detail: DetailEntity) -> Single<Void>
  func deleteFavoriteMovie() -> Single<Void>
  func isMovieFavorited() -> Single<Bool>
}

class DetailRepository {
  typealias DetailRepositoryInstance = (DetailDataSourceProtocol, DetailFavoriteDataSourceProtocol) -> DetailRepository
  let remote: DetailDataSourceProtocol
  let locale: DetailFavoriteDataSourceProtocol

  private init(remote: DetailDataSourceProtocol, locale: DetailFavoriteDataSourceProtocol) {
    self.remote = remote
    self.locale = locale
  }

  static let sharedInstance: DetailRepositoryInstance = { remote, locale in
    return DetailRepository(remote: remote, locale: locale)
  }
}

extension DetailRepository: DetailRepositoryProtocol {
  func getMovieDetail(source: DataRequestSource) -> Single<DetailEntity> {
    switch source {
    case .network:
      return remote.getMovieDetail()
        .map { MovieMapper.mapDetailMovieResponseToEntity(detail: $0)}
    case .local:
      return locale.getDetailFavoriteMovie()
    }
  }

  func saveMovieToFavorite(movie: MovieEntity, detail: DetailEntity) -> Single<Void> {
    locale.saveMovieToFavorite(movie: movie, detail: detail)
  }

  func deleteFavoriteMovie() -> Single<Void> {
    locale.deleteFavoriteMovie()
  }

  func isMovieFavorited() -> Single<Bool> {
    locale.isMovieFavorited()
  }
}
