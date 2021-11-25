//
//  Injection.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

import Foundation

final class Injection: NSObject {

  // MARK: - DataSource
  private func provideHomeDataSource() -> HomeDataSourceProtocol {
    let nowPlayingRequest = NowPlayingMovieRequest()
    let topRatedRequest = TopRatedMovieRequest()
    let genreRequest = GenreMovieRequest()
    return HomeDataSource.sharedInstance(nowPlayingRequest, topRatedRequest, genreRequest)
  }

  private func provideExploreDataSource() -> ExploreDataSourceProtocol {
    let popularRequest = PopularMovieRequest()
    let searchRequest = SearchMovieRequest()
    return ExploreDataSource.sharedInstance(popularRequest, searchRequest)
  }

  private func provideDetailDataSource(id: Int) -> DetailDataSourceProtocol {
    let detailRequest = DetailMovieRequest(movieID: id)
    return DetailDataSource.sharedInstance(detailRequest)
  }

  private func provideFavoriteDataSource() -> FavoriteDataSourceProtocol {
    let request = FavoriteRequest()
    return FavoriteDataSource.sharedInstance(request)
  }

  private func provideDetailFavoriteDataSource(id: Int) -> DetailFavoriteDataSourceProtocol {
    let isFavoritedReq = IsFavoritedRequest(id: id)
    let saveMovieReq = SaveMovieRequest()
    let deleteMovieReq = DeleteMovieRequest(id: id)
    let detailFavReq = DetailFavoriteRequest(id: id)
    return DetailFavoriteDataSource.sharedInstance(isFavoritedReq, saveMovieReq, deleteMovieReq, detailFavReq)
  }

  // MARK: - Repository
  private func provideHomeRepository() -> HomeRepositoryProtocol {
    let dataSource = provideHomeDataSource()
    return HomeRepository.sharedInstance(dataSource)
  }

  private func provideExploreRepository() -> ExploreRepositoryProtocol {
    let dataSource = provideExploreDataSource()
    return ExploreRepository.sharedInstance(dataSource)
  }

  private func provideDetailRepository(id: Int) -> DetailRepositoryProtocol {
    let remote = provideDetailDataSource(id: id)
    let locale = provideDetailFavoriteDataSource(id: id)
    return DetailRepository.sharedInstance(remote, locale)
  }

  private func provideFavoriteRepository() -> FavoriteRepositoryProtocol {
    let dataSource = provideFavoriteDataSource()
    return FavoriteRepository.sharedInstance(dataSource)
  }

  // MARK: - Use Case
  func provideHomeUseCase() -> HomeUseCase {
    let repository = provideHomeRepository()
    return HomeInteractor(repository: repository)
  }

  func provideExploreUseCase() -> ExploreUseCase {
    let repository = provideExploreRepository()
    return ExploreInteractor(repository: repository)
  }

  func provideDetailUseCase(id: Int, movie: MovieModel) -> DetailUseCase {
    let repository = provideDetailRepository(id: id)
    return DetailInteractor(repository: repository, movieModel: movie)
  }

  func provideFavoriteUseCase() -> FavoriteUseCase {
    let repository = provideFavoriteRepository()
    return FavoriteInteractor(repository: repository)
  }
}
