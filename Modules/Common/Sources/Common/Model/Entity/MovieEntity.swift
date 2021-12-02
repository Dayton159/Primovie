//
//  MovieEntity.swift
//  
//
//  Created by Dayton on 29/11/21.
//

import Foundation

public struct MovieEntity {
  public let idMovie: Int64?
  public let title: String?
  public let overview: String?
  public let releaseDate: Date?
  public let genres: [String]
  public let popularity: Double?
  public let rating: Double?
  public let backdropPath: String?
  public let posterPath: String?

  public init(
    idMovie: Int64?,
    title: String?,
    overview: String?,
    releaseDate: Date?,
    genres: [String],
    popularity: Double?,
    rating: Double?,
    backdropPath: String?,
    posterPath: String?
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
