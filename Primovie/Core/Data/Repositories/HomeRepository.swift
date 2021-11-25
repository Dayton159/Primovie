//
//  HomeRepository.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import RxSwift

protocol HomeRepositoryProtocol: AnyObject {
  func getNowPlayingMovies() -> Single<[MovieEntity]>
  func getTopRatedMovies() -> Single<[MovieEntity]>
}

class HomeRepository {
  typealias HomeRepositoryInstance = (HomeDataSourceProtocol) -> HomeRepository
  let homeDataSource: HomeDataSourceProtocol

  private init(homeDataSource: HomeDataSourceProtocol) {
    self.homeDataSource = homeDataSource
  }

  static let sharedInstance: HomeRepositoryInstance = { homeDataSource in
    return HomeRepository(homeDataSource: homeDataSource)
  }
}

extension HomeRepository: HomeRepositoryProtocol {
  func getNowPlayingMovies() -> Single<[MovieEntity]> {
    homeDataSource.getNowPlayingMovies()
      .flatMap { response in
        self.homeDataSource.getMovieGenres()
          .map {
            $0.genres
              .filter { response.flatMap { $0.genreIDs }.contains($0.id)}
              .map { $0.name }
          }
          .map {
            MovieMapper.mapMovieResponsesToEntity(movie: response, genre: $0)
          }
      }
  }

  func getTopRatedMovies() -> Single<[MovieEntity]> {
    homeDataSource.getTopRatedMovies()
      .map { MovieMapper.mapMovieResponsesToEntity(movie: $0)}
  }
}
