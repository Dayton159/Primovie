//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Foundation
import Common
@testable import Favorite

final class MockDI: NSObject {
  func provideRepository() -> MockFavoritesRepository {
    let mockDataStack = MockCoreDataStack()
    let locale = MockFavoritesDataSource(context: mockDataStack.context())
    let mapper = FavoritesMapper()

    return MockFavoritesRepository(remote: locale, mapper: mapper)
  }

  func provideUseCase() -> MockFavoritesInteractor {
    let repository = provideRepository()
    return MockFavoritesInteractor(repository: repository)
  }
}
