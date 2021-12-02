//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import XCTest
@testable import Detail

final class DeleteMovieRequestTests: XCTestCase {
  var sut: DeleteMovieRequest!

  override func setUp() {
    super.setUp()
    sut = DeleteMovieRequest(id: 88)
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_Delete_Request() {
    XCTAssertEqual(sut.entityName, "CDMovieFavorite")
    XCTAssertEqual(sut.fetchLimit, 1)
    XCTAssertEqual(sut.predicate, NSPredicate(format: "idMovie == 88"))
  }
}
