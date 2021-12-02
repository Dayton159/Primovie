//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Common
import Foundation

public struct SearchMovieRequest: APIRequest {
  public typealias Response = MovieListResponses
  public var pathname: String { "search/movie" }
  public var searchQuery: String?
  public var query: [URLQueryItem] {
    [
      URLQueryItem(name: "api_key", value: Environment.apiKey),
      URLQueryItem(name: "query", value: searchQuery)
    ]
  }

  public init() { }
}
