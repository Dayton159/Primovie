//
//  TopRatedMovieRequest.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

struct TopRatedMovieRequest: APIRequest {
  typealias Response = MovieListResponses
  var pathname: String { "movie/top_rated" }
}
