//
//  File.swift
//  
//
//  Created by Dayton on 30/11/21.
//

import XCTest
import RxSwift
@testable import Home

final class HomePresenterTests: XCTestCase {
  var disposeBag: DisposeBag!
  var sut: HomePresenter<MockHomeInteractor>!

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    sut = HomePresenter(useCase: MockDI.init().provideUseCase())

  }

  override func tearDown() {
    disposeBag = nil
    sut = nil
    super.tearDown()
  }

  func test_Presenter_Fetch_NowPlaying() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.nowPlayingObs.subscribe(onNext: { _ in
      expectation.fulfill()
    }, onError: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    sut.getMovies(.nowPlaying)
  }

  func test_Presenter_Fetch_TopRated() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.topRatedObs.subscribe(onNext: { _ in
      expectation.fulfill()
    }, onError: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    sut.getMovies(.topRated)
  }

  func test_Presenter_Loading() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.state.subscribe(onNext: { _ in
      expectation.fulfill()
    }, onError: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    sut.getMovies(.nowPlaying)
  }
}
