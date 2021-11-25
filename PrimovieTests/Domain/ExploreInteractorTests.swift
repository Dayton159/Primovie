//
//  ExploreInteractorTests.swift
//  PrimovieTests
//
//  Created by Dayton on 15/11/21.
//

import XCTest
import RxSwift
@testable import Primovie

class ExploreInteractorTests: XCTestCase {
  var disposeBag: DisposeBag!
  var sut: ExploreInteractorMock!

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    sut = ExploreInteractorMock()
  }

  override func tearDown() {
    disposeBag = nil
    sut = nil
    super.tearDown()
  }

  func test_Success_Get_Popular_Movies() {
    let expectation = XCTestExpectation(description: "Performs a request")
    sut.getPopularMovies().subscribe(onSuccess: { value in
      XCTAssertEqual(value, SampleDomain.listMovieModel)
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Failure_Get_Popular_Movies() {
    sut.expectedSuccess = false
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.getPopularMovies().subscribe(onSuccess: { value in
      XCTFail("Expected to fail, got value \(value) instead")
    }, onFailure: { _ in
      expectation.fulfill()
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Success_Get_SearchList_Movie_Matched() {
    sut.expectedKeyword = "Spider Man"
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.getMovieLists(by: "Spider Man").subscribe(onSuccess: { value in
      XCTAssertEqual(value, SampleDomain.listMovieModel)
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Failure_Get_SearchList_Movie_Matched() {
    sut.expectedSuccess = false
    sut.expectedKeyword = "Spider Man"
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.getMovieLists(by: "Spider Man").subscribe(onSuccess: { value in
      XCTFail("Expected to fail, got value \(value) instead")
    }, onFailure: { _ in
      expectation.fulfill()
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Failure_Get_SearchList_Movie_Unmatched() {
    sut.expectedKeyword = "Spider Man"
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.getMovieLists(by: "Spider Woman").subscribe(onSuccess: { value in
      XCTFail("Expected to fail, got value \(value) instead")
    }, onFailure: { _ in
      expectation.fulfill()
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }
}

class ExploreInteractorMock: ExploreUseCase {
  var expectedSuccess = true
  var expectedKeyword: String?

  func getPopularMovies() -> Single<[MovieModel]> {
    return Single<[MovieModel]>.create { single in

      if self.expectedSuccess {
        single(.success(SampleDomain.listMovieModel))
      } else {
        single(.failure(NSError(
          domain: "PrimovieTest",
          code: 404,
          userInfo: [NSLocalizedDescriptionKey: "Failed to fetch Popular data, expected result = \(self.expectedSuccess)"])))
      }
      return Disposables.create()
    }
  }

  func getMovieLists(by keyword: String) -> Single<[MovieModel]> {
    return Single<[MovieModel]>.create { single in

      if let expKeyword = self.expectedKeyword, expKeyword != keyword {
        single(.failure(NSError(
          domain: "PrimovieTest",
          code: 404,
          userInfo: [NSLocalizedDescriptionKey: "Search keyword did not match, expected result = \(expKeyword), passedKeyword = \(keyword)"])))
      }
      if self.expectedSuccess {
        single(.success(SampleDomain.listMovieModel))
      } else {
        single(.failure(NSError(
          domain: "PrimovieTest",
          code: 404,
          userInfo: [NSLocalizedDescriptionKey: "Failed to fetch search data, expected result = \(self.expectedSuccess)"])))
      }

      return Disposables.create()
    }
  }
}
