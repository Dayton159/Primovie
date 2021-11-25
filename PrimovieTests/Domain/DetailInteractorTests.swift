//
//  DetailInteractorTests.swift
//  PrimovieTests
//
//  Created by Dayton on 15/11/21.
//

import XCTest
import RxSwift
@testable import Primovie

class DetailInteractorTests: XCTestCase {
  var disposeBag: DisposeBag!
  var sut: DetailInteractorMock!

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    sut = DetailInteractorMock()
  }

  override func tearDown() {
    disposeBag = nil
    sut = nil
    super.tearDown()
  }

  func test_Success_Get_Movie_Detail_Remote () {
    let expectation = XCTestExpectation(description: "Performs a request")
    sut.getMovieDetail(source: .network).subscribe(onSuccess: { value in
      XCTAssertEqual(value, SampleDomain.detailModel)
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Failure_Get_Movie_Detail_Remote () {
    sut.expectedSuccess = false
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.getMovieDetail(source: .network).subscribe(onSuccess: { value in
      XCTFail("Expected to fail, got value \(value) instead")
    }, onFailure: { _ in
      expectation.fulfill()
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Success_Get_Movie_Detail_Local () {
    let expectation = XCTestExpectation(description: "Performs a request")
    sut.getMovieDetail(source: .local).subscribe(onSuccess: { value in
      XCTAssertEqual(value, SampleDomain.detailModelLocal)
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Failure_Get_Movie_Detail_Local () {
    sut.expectedSuccess = false
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.getMovieDetail(source: .local).subscribe(onSuccess: { value in
      XCTFail("Expected to fail, got value \(value) instead")
    }, onFailure: { _ in
      expectation.fulfill()
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Save_Movie_To_Favorite_Success() {
    let expectation = XCTestExpectation(description: "Performs a request")
    sut.saveMovieToFavorite(model: SampleDomain.detailModel).subscribe(onSuccess: { _ in
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Save_Movie_To_Favorite_Failure() {
    sut.expectedSuccess = false
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.saveMovieToFavorite(model: SampleDomain.detailModel).subscribe(onSuccess: { value in
      XCTFail("Expected to fail, got value \(value) instead")
    }, onFailure: { _ in
      expectation.fulfill()
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Delete_Movie_Favorite_Success() {
    let expectation = XCTestExpectation(description: "Performs a request")
    sut.deleteFavoriteMovie().subscribe(onSuccess: { _ in
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Delete_Movie_Favorite_Failure() {
    sut.expectedSuccess = false
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.deleteFavoriteMovie().subscribe(onSuccess: { value in
      XCTFail("Expected to fail, got value \(value) instead")
    }, onFailure: { _ in
      expectation.fulfill()
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Is_Favorited_Movie_Success() {
    sut.expectedFavorite = true
    let expectation = XCTestExpectation(description: "Performs a request")
    sut.isMovieFavorited().subscribe(onSuccess: { value in
      XCTAssertEqual(value, true)
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Is_Favorited_Movie_Failure() {
    sut.expectedSuccess = false
    sut.expectedFavorite = true
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.isMovieFavorited().subscribe(onSuccess: { value in
      XCTFail("Expected to fail, got value \(value) instead")
    }, onFailure: { _ in
      expectation.fulfill()
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Is_Not_Favorited_Movie_Success() {
    sut.expectedFavorite = false
    let expectation = XCTestExpectation(description: "Performs a request")
    sut.isMovieFavorited().subscribe(onSuccess: { value in
      XCTAssertEqual(value, false)
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Is_Not_Favorited_Movie_Failure() {
    sut.expectedSuccess = false
    sut.expectedFavorite = false
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.isMovieFavorited().subscribe(onSuccess: { value in
      XCTFail("Expected to fail, got value \(value) instead")
    }, onFailure: { _ in
      expectation.fulfill()
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }
}

class DetailInteractorMock: DetailUseCase {
  var expectedSuccess = true
  var expectedFavorite: Bool?

  func getMovieDetail(source: DataRequestSource) -> Single<DetailModel> {
    return Single<DetailModel>.create { single in

      if self.expectedSuccess {
        switch source {
        case .network:
          single(.success(SampleDomain.detailModel))
        case .local:
          single(.success(SampleDomain.detailModelLocal))
        }
      } else {
        single(.failure(NSError(
          domain: "PrimovieTest",
          code: 404,
          userInfo: [NSLocalizedDescriptionKey: "Failed to fetch Detail data, expected result = \(self.expectedSuccess)"])))
      }
      return Disposables.create()
    }
  }

  func saveMovieToFavorite(model: DetailModel) -> Single<Void> {
    return Single<Void>.create { single in

      if self.expectedSuccess {
        single(.success(()))
      } else {
        single(.failure(NSError(
          domain: "PrimovieTest",
          code: 404,
          userInfo: [NSLocalizedDescriptionKey: "Failed to save data, expected result = \(self.expectedSuccess)"])))
      }
      return Disposables.create()
    }
  }

  func deleteFavoriteMovie() -> Single<Void> {
    return Single<Void>.create { single in

      if self.expectedSuccess {
        single(.success(()))
      } else {
        single(.failure(NSError(
          domain: "PrimovieTest",
          code: 404,
          userInfo: [NSLocalizedDescriptionKey: "Failed to delete data, expected result = \(self.expectedSuccess)"])))
      }
      return Disposables.create()
    }
  }

  func isMovieFavorited() -> Single<Bool> {
    return Single<Bool>.create { single in
      if let expFav = self.expectedFavorite, self.expectedSuccess {
        single(.success(expFav))
      } else {
        single(.failure(NSError(
          domain: "PrimovieTest",
          code: 404,
          userInfo: [NSLocalizedDescriptionKey: "Failed to get favorite status , expected result = \(self.expectedSuccess)"])))
      }
      return Disposables.create()
    }
  }
}
