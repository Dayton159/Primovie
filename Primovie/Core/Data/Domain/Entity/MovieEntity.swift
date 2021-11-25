//
//  MovieEntity.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

import Foundation

struct MovieEntity {
  let idMovie: Int64?
  let title: String?
  let overview: String?
  let releaseDate: Date?
  let genres: [String]
  let popularity: Double?
  let rating: Double?
  let backdropPath: String?
  let posterPath: String?
}
