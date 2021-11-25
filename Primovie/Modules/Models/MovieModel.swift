//
//  MovieModel.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import Foundation

struct MovieModel: Hashable {
  let idMovie: Int
  let title: String
  let overview: String
  let releaseDate: String
  let genres: [String]
  let popularity: String
  let rating: String
  let backdropPath: String
  let posterPath: String

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  static func == (lhs: MovieModel, rhs: MovieModel) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  private let identifier = UUID()
}
