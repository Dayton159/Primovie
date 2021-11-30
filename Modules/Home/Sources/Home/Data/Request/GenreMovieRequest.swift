//
//  File.swift
//  
//
//  Created by Dayton on 29/11/21.
//

import Common

public struct GenreMovieRequest: APIRequest {
  public typealias Response = MovieGenreResponse
  public var pathname: String { "genre/movie/list" }
}
