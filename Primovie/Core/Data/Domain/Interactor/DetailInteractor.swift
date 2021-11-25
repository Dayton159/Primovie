//
//  DetailInteractor.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import RxSwift

protocol DetailUseCase: AnyObject {
  func getMovieDetail(source: DataRequestSource) -> Single<DetailModel>
  func saveMovieToFavorite(model: DetailModel) -> Single<Void>
  func deleteFavoriteMovie() -> Single<Void>
  func isMovieFavorited() -> Single<Bool>
}

class DetailInteractor {
  private let repository: DetailRepositoryProtocol
  private let movieModel: MovieModel

  init(repository: DetailRepositoryProtocol, movieModel: MovieModel) {
    self.repository = repository
    self.movieModel = movieModel
  }
}

extension DetailInteractor: DetailUseCase {
  func getMovieDetail(source: DataRequestSource) -> Single<DetailModel> {
    repository.getMovieDetail(source: source)
      .map { MovieMapper.mapDetailMovieToDomain(movie: self.movieModel, detail: $0)}
  }

  func saveMovieToFavorite(model: DetailModel) -> Single<Void> {
    let entity = MovieMapper.mapDetailModelToEntity(detail: model)
    return repository.saveMovieToFavorite(movie: entity.movie, detail: entity.detail)
  }

  func deleteFavoriteMovie() -> Single<Void> {
    repository.deleteFavoriteMovie()
  }

  func isMovieFavorited() -> Single<Bool> {
    repository.isMovieFavorited()
  }
}
