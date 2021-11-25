//
//  PopularMovieRequest.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

struct PopularMovieRequest: APIRequest {
  typealias Response = MovieListResponses
  var pathname: String { "movie/popular" }
}
