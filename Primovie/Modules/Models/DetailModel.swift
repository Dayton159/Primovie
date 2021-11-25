//
//  DetailModel.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

struct DetailModel: Equatable {
  let idMovie: Int
  let title: String
  let overview: String
  let releaseDate: String
  let genres: [String]
  let popularity: String
  let rating: String
  let backdropPath: String
  let posterPath: String
  let tagline: String
  let status: String
  let runtime: String
  let language: String
}
