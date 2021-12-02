//
//  APIRequest.swift
//  
//
//  Created by Dayton on 29/11/21.
//

import Foundation
import Alamofire

public struct EmptyResponse: Codable { }

public protocol APIRequest {
  associatedtype Response: Codable

  var pathname: String { get }
  var method: HTTPMethod { get }
  var query: [URLQueryItem] { get }
  var contentType: String { get }
}

public extension APIRequest {
  typealias Response = EmptyResponse

  var method: HTTPMethod { .get }
  var query: [URLQueryItem] { [URLQueryItem(name: "api_key", value: Environment.apiKey)] }
  var contentType: String { "application/json" }
}

public extension APIRequest {
  func makeURLComponents() -> URLComponents {
    guard var components = URLComponents(string: Environment.baseURL + pathname)
    else { fatalError("Couldn't create URLComponents") }
    components.queryItems = query

    return components
  }

  func makeURLRequest() -> URLRequest {
    let components = makeURLComponents()
    guard let url = components.url else { fatalError("Empty Component URL")}

    var urlRequest = URLRequest(url: url)
    urlRequest.method = method
    urlRequest.headers.add(.contentType(contentType))

    return urlRequest
  }
}
