//
//  File.swift
//  
//
//  Created by Dayton on 30/11/21.
//

import Foundation
@testable import Home

final class MockDI: NSObject {
  func provideRepository() -> MockHomeRepository {
    let remote = MockHomeDataSource()
    let mapper = HomeMapper()
    return MockHomeRepository(remote: remote, mapper: mapper)
  }

  func provideUseCase() -> MockHomeInteractor {
    let repository = provideRepository()
    return MockHomeInteractor(repository: repository)
  }
}
