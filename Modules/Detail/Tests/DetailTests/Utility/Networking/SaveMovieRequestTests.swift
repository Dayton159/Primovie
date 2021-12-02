//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import XCTest
@testable import Detail

final class SaveMovieRequestTests: XCTestCase {
  var sut: SaveMovieRequest!

  override func setUp() {
    super.setUp()
    sut = SaveMovieRequest()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_Save_Request() {
    XCTAssertEqual(sut.entityName, "CDMovieFavorite")
    XCTAssertEqual(sut.fetchLimit, 1)
    XCTAssertEqual(sut.predicate, nil)
  }
}
