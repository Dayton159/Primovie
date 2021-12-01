//
//  APIRequestTests.swift
//  
//
//  Created by Dayton on 30/11/21.
//

import Common
import XCTest
import Alamofire
import RxSwift
@testable import Home

final class APIRequestTests: XCTestCase {
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
    let request = HomeMovieRequest()

    API(apiService: sut)
      .fetch(request)
      .subscribe(onSuccess: { value in
        XCTFail("Expected to fail, got value \(value) instead")
      }, onFailure: { _ in
        expectation.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_NowPlaying_Fetch() {
    guard let expected = try? JSONDecoder().decode(MovieListResponses.self, from: SampleJSON.list.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }

    sut.dummyResponse = SampleJSON.list
    sut.expPathname = "/3/movie/now_playing"
    sut.expQueryItemParam = "api_key"
    sut.expQueryItemString = Environment.apiKey

    let expectation = XCTestExpectation(description: "Performs a request")
    let request = HomeMovieRequest(path: .nowPlaying)

    API(apiService: sut)
      .fetch(request).subscribe(onSuccess: { value in
        XCTAssertEqual(value, expected)
        expectation.fulfill()
      }, onFailure: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_TopRated_Fetch() {
    guard let expected = try? JSONDecoder().decode(MovieListResponses.self, from: SampleJSON.list.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }

    sut.dummyResponse = SampleJSON.list
    sut.expPathname = "/3/movie/top_rated"
    sut.expQueryItemParam = "api_key"
    sut.expQueryItemString = Environment.apiKey

    let expectation = XCTestExpectation(description: "Performs a request")
    let request = HomeMovieRequest(path: .topRated)

    API(apiService: sut)
      .fetch(request).subscribe(onSuccess: { value in
        XCTAssertEqual(value, expected)
        expectation.fulfill()
      }, onFailure: { error in
        XCTFail("Expected to success, got error \(error) instead")
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_GenreMovie_Fetch() {
    guard let expected = try? JSONDecoder().decode(MovieGenreResponse.self, from: SampleJSON.genre.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }

    sut.dummyResponse = SampleJSON.genre
    sut.expPathname = "/3/genre/movie/list"
    sut.expQueryItemParam = "api_key"
    sut.expQueryItemString = Environment.apiKey

    let expectation = XCTestExpectation(description: "Performs a request")
    let request = GenreMovieRequest()

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
