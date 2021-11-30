//
//  File.swift
//  
//
//  Created by Dayton on 30/11/21.
//

import Foundation
import Primovie_Core
@testable import Home

final class MockDI: NSObject {
  func provideRepository() -> MockHomeRepository {
    let remote = MockMovieListDataSource()
    let mapper = HomeMapper()
    return MockHomeRepository(remote: remote, mapper: mapper)
  }

  func provideUseCase() -> MockHomeInteractor {
    let repository = provideRepository()
    return MockHomeInteractor(repository: repository)
  }
}
