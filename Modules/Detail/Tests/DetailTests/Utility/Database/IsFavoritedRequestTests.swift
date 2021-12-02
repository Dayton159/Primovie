//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import XCTest
@testable import Detail

final class IsFavoritedRequestTests: XCTestCase {
  var sut: IsFavoritedRequest!

  override func setUp() {
    super.setUp()
    sut = IsFavoritedRequest(id: 19)
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_Detail_Local_Request() {
    XCTAssertEqual(sut.entityName, "CDMovieFavorite")
    XCTAssertEqual(sut.fetchLimit, 1)
    XCTAssertEqual(sut.predicate, NSPredicate(format: "idMovie == 19"))
  }
}
