//
//  HomeMovieRequest.swift
//  
//
//  Created by Dayton on 29/11/21.
//

import Common

public struct HomeMovieRequest: APIRequest {
  public typealias Response = MovieListResponses
  public var path: MovieRequest?
  public var pathname: String {
    path?.name ?? "movie/now_playing"
  }

  public init(path: MovieRequest? = nil) {
    self.path = path
  }
}
