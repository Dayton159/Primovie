//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Common

public struct DetailRemoteRequest: APIRequest {
  public typealias Response = DetailMovieResponse
  public var movieID: Int
  public var pathname: String { "movie/\(movieID)" }
}
