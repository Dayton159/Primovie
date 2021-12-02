//
//  File.swift
//  
//
//  Created by Dayton on 29/11/21.
//

public struct DetailMovieResponse: Codable, Equatable {
  public let tagline: String?
  public let status: String?
  public let runtime: Int?
  public let genres: [Genre]
  public let language: [MovieLanguage]

  private enum CodingKeys: String, CodingKey {
    case tagline, status, genres, runtime
    case language = "spoken_languages"
  }
}

public struct MovieLanguage: Codable, Equatable {
  public let name: String

  private enum CodingKeys: String, CodingKey {
    case name = "english_name"
  }
}
