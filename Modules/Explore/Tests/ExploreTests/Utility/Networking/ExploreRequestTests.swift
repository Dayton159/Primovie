//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Common
import XCTest
import Alamofire
import RxSwift
@testable import Explore

final class ExploreRequestTests: XCTestCase {
  var disposeBag: DisposeBag!
  var sut: MockAPIService!

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    sut = MockAPIService()
  }

  override func tearDown() {
    disposeBag = nil
    sut = nil
    super.tearDown()
  }

  func test_Fetch_With_Error() {
    sut.expError = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 404))
    sut.expQueryItemParam = "api_key"
    sut.expQueryItemString = Environment.apiKey

    let expectation = XCTestExpectation(description: "Performs a request")
    let request = PopularMovieRequest()

    API(apiService: sut)
      .fetch(request)
      .subscribe(onSuccess: { value in
        XCTFail("Expected to fail, got value \(value) instead")
      }, onFailure: { _ in
        expectation.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Popular_Fetch() {
    guard let expected = try? JSONDecoder().decode(MovieListResponses.self, from: SampleJSON.list.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }

    sut.dummyResponse = SampleJSON.list
    sut.expPathname = "/3/movie/popular"
    sut.expQueryItemParam = "api_key"
    sut.expQueryItemString = Environment.apiKey

    let expectation = XCTestExpectation(description: "Performs a request")
    let request = PopularMovieRequest()

    API(apiService: sut)
      .fetch(request).subscribe(onSuccess: { value in
        XCTAssertEqual(value, expected)
        expectation.fulfill()
      }, onFailure: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Search_Fetch() {
    guard let expected = try? JSONDecoder().decode(MovieListResponses.self, from: SampleJSON.list.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }

    sut.dummyResponse = SampleJSON.list
    sut.expPathname = "/3/search/movie"
    sut.expQueryItemParam = "query"
    sut.expQueryItemString = "Iron Man"

    let expectation = XCTestExpectation(description: "Performs a request")
    var request = SearchMovieRequest()
    request.searchQuery = "Iron Man"

    API(apiService: sut)
      .fetch(request).subscribe(onSuccess: { value in
        XCTAssertEqual(value, expected)
        expectation.fulfill()
      }, onFailure: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }
}
