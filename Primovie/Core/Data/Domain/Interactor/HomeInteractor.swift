//
//  HomeInteractor.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import RxSwift

protocol HomeUseCase: AnyObject {
  func getNowPlayingMovies() -> Single<[MovieModel]>
  func getTopRatedMovies() -> Single<[MovieModel]>
}

class HomeInteractor {
  private let repository: HomeRepositoryProtocol

  init(repository: HomeRepositoryProtocol) {
    self.repository = repository
  }
}

extension HomeInteractor: HomeUseCase {
  func getNowPlayingMovies() -> Single<[MovieModel]> {
    repository.getNowPlayingMovies()
      .map { MovieMapper.mapMovieEntityToDomain(movie: $0) }
  }

  func getTopRatedMovies() -> Single<[MovieModel]> {
    repository.getTopRatedMovies()
      .map { MovieMapper.mapMovieEntityToDomain(movie: $0) }
  }
}
