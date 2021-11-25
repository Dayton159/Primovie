//
//  NowPlayingMovieRequest.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

struct NowPlayingMovieRequest: APIRequest {
  typealias Response = MovieListResponses
  var pathname: String { "movie/now_playing" }
}
