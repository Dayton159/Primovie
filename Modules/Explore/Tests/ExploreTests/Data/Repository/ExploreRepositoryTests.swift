//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import XCTest
import Common
import RxSwift

final class ExploreRepositoryTests: XCTestCase {
  var disposeBag: DisposeBag!
  var sut: MockExploreRepository!

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

  func test_Fetch_Popular() {
    let expected = MovieModel.samples.map { $0.idMovie }
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.execute(request: nil).subscribe(onSuccess: { value in
      XCTAssertEqual(value.map { $0.idMovie }, expected)
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)
  }

  func test_Fetch_Search() {
    let expected = MovieModel.samples.map { $0.idMovie }
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.execute(request: "Iron Man").subscribe(onSuccess: { value in
      XCTAssertEqual(value.map { $0.idMovie }, expected)
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)
  }
}
