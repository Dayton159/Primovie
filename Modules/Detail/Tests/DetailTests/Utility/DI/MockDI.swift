//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Foundation
import Common
@testable import Detail

final class MockDI: NSObject {
  func provideMovieRepository(request: DataRequestSource = .network) -> MockDetailMovieRepository {
    let mockDataStack = MockCoreDataStack()
    let remote = MockRemoteDataSource()
    let local = MockLocalDataSource(context: mockDataStack.context())
    let remoteMapper = RemoteMapper()
    let localMapper = LocalMapper()
    let model = request == .network ? MovieModel.sample : MovieModel.sampleLocal

    return MockDetailMovieRepository(
      remote: remote,
      local: local,
      mapperRemote: remoteMapper,
      mapperLocal: localMapper,
      model: model)
  }

  func provideSaveRepository() -> MockSaveRepository {
    let local = MockSaveDataSource()
    let mapper = SaveMapper()

    return MockSaveRepository(local: local, mapper: mapper)
  }

  func provideDeleteRepository() -> MockDeleteRepository {
    let local = MockDeleteDataSource()
    return MockDeleteRepository(local: local)
  }

  func provideIsFavoriteRepository() -> MockIsFavoriteRepository {
    let local = MockIsFavoritedDataSource()

    return MockIsFavoriteRepository(local: local)
  }

  func providePresenter() -> MockDetailPresenter {
    let detail = MockDetailMovieInteractor(repository: provideMovieRepository())
    let save = MockSaveMovieInteractor(repository: provideSaveRepository())
    let delete = MockDeleteMovieInteractor(repository: provideDeleteRepository())
    let isFav = MockIsFavMovieInteractor(repository: provideIsFavoriteRepository())

    return MockDetailPresenter(
      detailUseCase: detail,
      saveUseCase: save,
      deleteUseCase: delete,
      isFavUseCase: isFav)
  }
}
