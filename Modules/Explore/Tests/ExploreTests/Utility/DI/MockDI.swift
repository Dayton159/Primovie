//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Foundation
@testable import Explore

final class MockDI: NSObject {
  func provideRepository() -> MockExploreRepository {
    let remote = MockExploreDataSource()
    let mapper = ExploreMapper()
    return MockExploreRepository(remote: remote, mapper: mapper)
  }

  func provideUseCase() -> MockExploreInteractor {
    let repository = provideRepository()
    return MockExploreInteractor(repository: repository)
  }
}
