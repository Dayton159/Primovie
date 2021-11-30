//
//  File.swift
//  
//
//  Created by Dayton on 29/11/21.
//

public struct DetailModel: Equatable {
  public let idMovie: Int
  public let title: String
  public let overview: String
  public let releaseDate: String
  public let genres: [String]
  public let popularity: String
  public let rating: String
  public let backdropPath: String
  public let posterPath: String
  public let tagline: String
  public let status: String
  public let runtime: String
  public let language: String

  public init(
    idMovie: Int,
    title: String,
    overview: String,
    releaseDate: String,
    genres: [String],
    popularity: String,
    rating: String,
    backdropPath: String,
    posterPath: String,
    tagline: String,
    status: String,
    runtime: String,
    language: String
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
    self.tagline = tagline
    self.status = status
    self.runtime = runtime
    self.language = language
  }
}
