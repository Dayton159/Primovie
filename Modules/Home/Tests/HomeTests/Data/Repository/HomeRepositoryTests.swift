//
//  HomeRepositoryTests.swift
//  
//
//  Created by Dayton on 30/11/21.
//

import XCTest
import Common
import RxSwift

final class HomeRepositoryTests: XCTestCase {
  var disposeBag: DisposeBag!
  var sut: MockHomeRepository!

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    sut = MockDI.init().provideRepository()
  }

  override func tearDown() {
    disposeBag = nil
    sut = nil
    super.tearDown()
  }

  func test_Fetch_NowPlaying() {
    let expected = MovieModel.samples.map { $0.idMovie }
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.execute(request: .nowPlaying).subscribe(onSuccess: { value in
      XCTAssertEqual(value.map { $0.idMovie }, expected)
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Fetch_TopRated() {
    let expected = MovieModel.samples.map { $0.idMovie }
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.execute(request: .topRated).subscribe(onSuccess: { value in
      XCTAssertEqual(value.map { $0.idMovie }, expected)
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }
}
