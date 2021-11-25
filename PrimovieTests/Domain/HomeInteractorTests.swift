//
//  HomeInteractorTests.swift
//  PrimovieTests
//
//  Created by Dayton on 15/11/21.
//

import XCTest
import RxSwift
@testable import Primovie

class HomeInteractorTests: XCTestCase {
  var disposeBag: DisposeBag!
  var sut: HomeInteractorMock!

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    sut = HomeInteractorMock()
  }

  override func tearDown() {
    disposeBag = nil
    sut = nil
    super.tearDown()
  }

  func test_Success_Get_NowPlaying_Movies() {
    let expectation = XCTestExpectation(description: "Performs a request")
    sut.getNowPlayingMovies().subscribe(onSuccess: { value in
      XCTAssertEqual(value, SampleDomain.listMovieModel)
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Failure_Get_NowPlaying_Movies() {
    sut.expectedSuccess = false
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.getNowPlayingMovies().subscribe(onSuccess: { value in
      XCTFail("Expected to fail, got value \(value) instead")
    }, onFailure: { _ in
      expectation.fulfill()
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Success_Get_TopRated_Movies() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.getTopRatedMovies().subscribe(onSuccess: { value in
      XCTAssertEqual(value, SampleDomain.listMovieModel)
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Failure_Get_TopRated_Movies() {
    sut.expectedSuccess = false
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.getTopRatedMovies().subscribe(onSuccess: { value in
      XCTFail("Expected to fail, got value \(value) instead")
    }, onFailure: { _ in
      expectation.fulfill()
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }
}

class HomeInteractorMock: HomeUseCase {
  var expectedSuccess = true

  func getNowPlayingMovies() -> Single<[MovieModel]> {
    return Single<[MovieModel]>.create { single in

      if self.expectedSuccess {
        single(.success(SampleDomain.listMovieModel))
      } else {
        single(.failure(NSError(
          domain: "PrimovieTest",
          code: 404,
          userInfo: [NSLocalizedDescriptionKey: "Failed to fetch nowPlaying data, expected result = \(self.expectedSuccess)"])))
      }
      return Disposables.create()
    }
  }

  func getTopRatedMovies() -> Single<[MovieModel]> {
    return Single<[MovieModel]>.create { single in

      if self.expectedSuccess {
        single(.success(SampleDomain.listMovieModel))
      } else {
        single(.failure(NSError(
          domain: "PrimovieTest",
          code: 404,
          userInfo: [NSLocalizedDescriptionKey: "Failed to fetch topRated data, expected result = \(self.expectedSuccess)"])))
      }
      return Disposables.create()
    }
  }

}
