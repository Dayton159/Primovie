//
//  DetailMovieRequest.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

struct DetailMovieRequest: APIRequest {
  typealias Response = DetailMovieResponse
  var movieID: Int
  var pathname: String { "movie/\(movieID)" }
}
