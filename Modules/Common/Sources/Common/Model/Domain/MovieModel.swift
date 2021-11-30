//
//  MovieModel.swift
//  
//
//  Created by Dayton on 29/11/21.
//

import Foundation

public struct MovieModel: Hashable {
  public let idMovie: Int
  public let title: String
  public let overview: String
  public let releaseDate: String
  public let genres: [String]
  public let popularity: String
  public let rating: String
  public let backdropPath: String
  public let posterPath: String

  public func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  public static func == (lhs: MovieModel, rhs: MovieModel) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  private let identifier = UUID()

  public init(
    idMovie: Int,
    title: String,
    overview: String,
    releaseDate: String,
    genres: [String],
    popularity: String,
    rating: String,
    backdropPath: String,
    posterPath: String
  ) {
    self.idMovie = idMovie
    self.title = title
    self.overview = overview
    self.releaseDate = releaseDate
    self.genres = genres
    self.popularity = popularity
    self.rating = rating
    self.backdropPath = backdropPath
    self.posterPath = posterPath
  }
}
