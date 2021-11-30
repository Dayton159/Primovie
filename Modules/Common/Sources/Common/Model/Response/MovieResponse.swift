//
//  MovieResponse.swift
//  
//
//  Created by Dayton on 29/11/21.
//

public struct MovieListResponses: Codable, Equatable {
  public let results: [MovieResponse]
}

public struct MovieResponse: Codable, Equatable {
  public let posterPath: String?
  public let overview: String?
  public let releaseDate: String?
  public let genreIDs: [Int]
  public let idMovie: Int?
  public let title: String?
  public let backdropPath: String?
  public let popularity: Double?
  public let rating: Double?

  private enum CodingKeys: String, CodingKey {
    case overview, title, popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case genreIDs = "genre_ids"
    case idMovie = "id"
    case backdropPath = "backdrop_path"
    case rating = "vote_average"
  }
}
