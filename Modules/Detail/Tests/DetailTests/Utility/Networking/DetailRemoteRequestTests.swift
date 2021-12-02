//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Common
import XCTest
import Alamofire
import RxSwift
@testable import Detail

final class DetailRemoteRequestTests: XCTestCase {
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
    let request = DetailRemoteRequest(movieID: 100)

    API(apiService: sut)
      .fetch(request)
      .subscribe(onSuccess: { value in
        XCTFail("Expected to fail, got value \(value) instead")
      }, onFailure: { _ in
        expectation.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Detail_Remote_Fetch() {
    guard let expected = try? JSONDecoder().decode(DetailMovieResponse.self, from: SampleJSON.detail.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    let expectation = XCTestExpectation(description: "Performs a request")
    let request = DetailRemoteRequest(movieID: 100)

    sut.dummyResponse = SampleJSON.detail
    sut.expPathname = "/3/movie/100"
    sut.expQueryItemParam = "api_key"
    sut.expQueryItemString = Environment.apiKey

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
