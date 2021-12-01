//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import XCTest
@testable import Favorite

final class FavoritesRequestTests: XCTestCase {
  var sut: FavoritesRequest!

  override func setUp() {
    super.setUp()
    sut = FavoritesRequest()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_Favorites_Request() {
    XCTAssertEqual(sut.entityName, "CDMovieFavorite")
    XCTAssertEqual(sut.fetchLimit, 1)
    XCTAssertEqual(sut.predicate, nil)
  }
}
