//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import XCTest
import Common
import RxSwift

final class MovieRepositoryTests: XCTestCase {
  var disposeBag: DisposeBag!
  var sut: MockDetailMovieRepository!

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    sut = MockDI.init().provideMovieRepository()
  }

  override func tearDown() {
    disposeBag = nil
    sut = nil
    super.tearDown()
  }

  func test_Fetch_Fav_Remote() {
    let expected = DetailModel.sample
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.execute(request: .network)
      .subscribe(onSuccess: { value in
        XCTAssertEqual(value, expected)
        expectation.fulfill()
      }, onFailure: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Fetch_Fav_Local() {
    sut = MockDI.init().provideMovieRepository(request: .local)
    let expected = DetailModel.sampleLocal
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.execute(request: .local)
      .subscribe(onSuccess: { value in
        XCTAssertEqual(value, expected)
        expectation.fulfill()
      }, onFailure: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }
}
