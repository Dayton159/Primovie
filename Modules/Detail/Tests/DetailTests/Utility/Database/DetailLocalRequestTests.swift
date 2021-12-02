//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import XCTest
@testable import Detail

final class DetailLocalRequestTests: XCTestCase {
  var sut: DetailLocalRequest!

  override func setUp() {
    super.setUp()
    sut = DetailLocalRequest(id: 10)
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_Detail_Local_Request() {
    XCTAssertEqual(sut.entityName, "CDMovieFavorite")
    XCTAssertEqual(sut.fetchLimit, 1)
    XCTAssertEqual(sut.predicate, NSPredicate(format: "idMovie == 10"))
  }
}
