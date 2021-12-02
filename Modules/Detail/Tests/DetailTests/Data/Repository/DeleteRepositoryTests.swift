//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import XCTest
import Common
import RxSwift

final class DeleteRepositoryTests: XCTestCase {
  var disposeBag: DisposeBag!
  var sut: MockDeleteRepository!

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    sut = MockDI.init().provideDeleteRepository()
  }

  override func tearDown() {
    disposeBag = nil
    sut = nil
    super.tearDown()
  }

  func test_Delete_Movie() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.execute(request: nil)
      .subscribe(onSuccess: { _ in
        expectation.fulfill()
      }, onFailure: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }
}
