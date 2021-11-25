//
//  DetailMovieResponse.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

struct DetailMovieResponse: Codable, Equatable {
  let tagline: String?
  let status: String?
  let runtime: Int?
  let genres: [Genre]
  let language: [MovieLanguage]

  private enum CodingKeys: String, CodingKey {
    case tagline, status, genres, runtime
    case language = "spoken_languages"
  }
}

struct MovieLanguage: Codable, Equatable {
    let name: String

  private enum CodingKeys: String, CodingKey {
    case name = "english_name"
  }
}

struct Genre: Codable, Equatable {
    let id: Int
    let name: String
}
