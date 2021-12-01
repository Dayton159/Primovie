//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import XCTest
import RxSwift

final class FavoritesPresenterTests: XCTestCase {
  var disposeBag: DisposeBag!
  var sut: MockFavoritesPresenter!

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    sut = MockFavoritesPresenter(useCase: MockDI.init().provideUseCase())
  }

  override func tearDown() {
    disposeBag = nil
    sut = nil
    super.tearDown()
  }

  func test_Presenter_Fetch_Favorites() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.listObs
      .filter { !$0.isEmpty }
      .subscribe(onNext: { _ in
        expectation.fulfill()
      }, onError: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    sut.getList(request: nil)

    wait(for: [expectation], timeout: 2)
  }

  func test_Presenter_Loading() {
    let expectation = XCTestExpectation(description: "Performs a request")

    sut.state.subscribe(onNext: { _ in
      expectation.fulfill()
    }, onError: { error in
      XCTFail("Expected to success, got error \(error) instead")
    }).disposed(by: disposeBag)

    sut.getList(request: nil)

    wait(for: [expectation], timeout: 2)
  }
}
