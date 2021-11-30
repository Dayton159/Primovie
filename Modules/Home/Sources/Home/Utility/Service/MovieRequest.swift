//
//  File.swift
//  
//
//  Created by Dayton on 30/11/21.
//

import Common

public enum MovieRequest {
  case nowPlaying
  case topRated

  public var name: String {
    switch self {
    case .nowPlaying:
      return "movie/now_playing"
    case .topRated:
      return "movie/top_rated"
    }
  }
}
