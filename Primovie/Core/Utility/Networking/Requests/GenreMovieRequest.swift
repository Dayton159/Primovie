//
//  GenreMovieRequest.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

struct GenreMovieRequest: APIRequest {
  typealias Response = MovieGenreResponse
  var pathname: String { "genre/movie/list" }
}
