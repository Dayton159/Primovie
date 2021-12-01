//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Common

public struct PopularMovieRequest: APIRequest {
  public typealias Response = MovieListResponses
  public var pathname: String { "movie/popular" }
}
