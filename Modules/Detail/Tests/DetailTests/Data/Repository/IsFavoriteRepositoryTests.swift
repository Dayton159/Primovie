//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import XCTest
import Common
import RxSwift

final class IsFavoriteRepositoryTests: XCTestCase {
  var disposeBag: DisposeBag!
  var sut: MockIsFavoriteRepository!

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    sut = MockDI.init().provideIsFavoriteRepository()
  }

  override func tearDown() {
    disposeBag = nil
    sut = nil
    super.tearDown()
  }

  func test_IsFavorite_Movie() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.execute(request: nil)
      .subscribe(onSuccess: { value in
        XCTAssertTrue(value)
        expectation.fulfill()
      }, onFailure: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }
}
