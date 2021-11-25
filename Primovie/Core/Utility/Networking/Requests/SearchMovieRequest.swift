//
//  SearchMovieRequest.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import Foundation

struct SearchMovieRequest: APIRequest {
  typealias Response = MovieListResponses
  var pathname: String { "search/movie" }
  var searchQuery: String?
  var query: [URLQueryItem] {
    [
      URLQueryItem(name: "api_key", value: Environment.apiKey),
      URLQueryItem(name: "query", value: searchQuery)
    ]
  }
}
