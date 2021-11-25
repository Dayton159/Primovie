//
//  MovieResponse.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

struct MovieListResponses: Codable, Equatable {
    let results: [MovieResponse]
}

struct MovieResponse: Codable, Equatable {
  let posterPath: String?
  let overview: String?
  let releaseDate: String?
  let genreIDs: [Int]
  let idMovie: Int?
  let title: String?
  let backdropPath: String?
  let popularity: Double?
  let rating: Double?

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
