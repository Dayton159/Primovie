//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import XCTest
import RxSwift
import Common

final class DetailPresenterTests: XCTestCase {
  var disposeBag: DisposeBag!
  var sut: MockDetailPresenter!

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    sut = MockDI.init().providePresenter()
  }

  override func tearDown() {
    disposeBag = nil
    sut = nil
    super.tearDown()
  }

  func test_Get_Movie_Detail_Remote() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.detailMovieObs
      .filter { $0 != nil }
      .subscribe(onNext: { _ in
        expectation.fulfill()
      }, onError: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    sut.getMovieDetail()

    wait(for: [expectation], timeout: 2)
  }

  func test_Get_Movie_Detail_Local() {
    sut = MockDI.init().providePresenter(request: .local)
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.detailMovieObs
      .filter { $0 != nil }
      .subscribe(onNext: { _ in
        expectation.fulfill()
      }, onError: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    sut.getMovieDetail()

    wait(for: [expectation], timeout: 2)
  }

  func test_Save_Movie_Favorite() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.isFavoriteObs
      .subscribe(onNext: { value in
        XCTAssertTrue(value)
        expectation.fulfill()
      }, onError: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    sut.detailMovieObs
      .filter { $0 != nil }
      .subscribe(onNext: { _ in
        self.sut.saveMovieToFavorite()
      }, onError: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    sut.getMovieDetail()

    wait(for: [expectation], timeout: 2)
  }

  func test_Delete_Movie_Favorite() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.isFavoriteObs
      .subscribe(onNext: { value in
        XCTAssertFalse(value)
        expectation.fulfill()
      }, onError: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    sut.deleteFavoriteMovie()

    wait(for: [expectation], timeout: 2)
  }

  func test_Is_Movie_Favorited() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.isFavoriteObs
      .subscribe(onNext: { _ in
        expectation.fulfill()
      }, onError: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    sut.isMovieFavorited()

    wait(for: [expectation], timeout: 2)
  }

  func test_Presenter_Loading() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.state.subscribe(onNext: { _ in
      expectation.fulfill()
    }, onError: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    sut.getMovieDetail()

    wait(for: [expectation], timeout: 2)
  }
}
