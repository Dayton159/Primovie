//
//  NetworkAPITests.swift
//  
//
//  Created by Dayton on 29/11/21.
//

import XCTest
import Alamofire
import RxSwift
@testable import Common

class NetworkAPITests: XCTestCase {
  var sut: Session!
  var disposeBag: DisposeBag!

  override func setUp() {
    super.setUp()
    sut = {
      let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        return configuration
      }()

      return Session(configuration: configuration)
    }()
    disposeBag = DisposeBag()
  }

  override func tearDown() {
    sut = nil
    disposeBag = nil
    super.tearDown()
  }

  func test_Fetch_Success() {
    let response = """
{
  "title": "some title",
  "overview": "some overview",
  "rating": 4.2
}
"""
    MockURLProtocol.responseWithStatusCode(code: 200, data: response.data(using: .utf8))
    guard let expected = try? JSONDecoder().decode(MockResponse.self, from: response.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    let request = MockAPIRequest()
    let expectation = XCTestExpectation(description: "Performs a request")

    API(apiService: AlamofireService(session: sut))
      .fetch(request)
      .subscribe(onSuccess: { value in
        XCTAssertEqual(value, expected)
        expectation.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }

  func test_Fetch_Error() {
    let errorResponse = """
{
    "success": false,
    "status_code": 34,
    "status_message": "The resource you requested could not be found."
}
"""
    MockURLProtocol.responseWithStatusCode(code: 404, data: errorResponse.data(using: .utf8))

    let request = MockAPIRequest()
    let expectation = XCTestExpectation(description: "Performs a request")

    API(apiService: AlamofireService(session: sut))
      .fetch(request)
      .subscribe(onSuccess: { value in
        XCTFail("Expected to fail, got value \(value) instead")
      }, onFailure: { _ in
        expectation.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 2)
  }
}
