//
//  HomeDataSource.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import Foundation
import RxSwift

protocol HomeDataSourceProtocol: AnyObject {
  func getNowPlayingMovies() -> Single<[MovieResponse]>
  func getTopRatedMovies() -> Single<[MovieResponse]>
  func getMovieGenres() -> Single<MovieGenreResponse>
}

class HomeDataSource: NSObject {
  typealias HomeDataSourceInstance = (NowPlayingMovieRequest, TopRatedMovieRequest, GenreMovieRequest) -> HomeDataSource
  private let nowPlaying: NowPlayingMovieRequest
  private let topRated: TopRatedMovieRequest
  private let genres: GenreMovieRequest

  private init(nowPlaying: NowPlayingMovieRequest, topRated: TopRatedMovieRequest, genres: GenreMovieRequest) {
    self.nowPlaying = nowPlaying
    self.topRated = topRated
    self.genres = genres
  }

  static let sharedInstance: HomeDataSourceInstance = { nowPlaying, topRated, genres in
    return HomeDataSource(
      nowPlaying: nowPlaying,
      topRated: topRated,
      genres: genres
    )
  }
}

extension HomeDataSource: HomeDataSourceProtocol {
  func getNowPlayingMovies() -> Single<[MovieResponse]> {
    return API()
      .fetch(nowPlaying)
      .map { $0.results }
  }

  func getTopRatedMovies() -> Single<[MovieResponse]> {
    return API()
      .fetch(topRated)
      .map { $0.results }
  }

  func getMovieGenres() -> Single<MovieGenreResponse> {
    return API()
      .fetch(genres)
  }
}
