//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import Common

public struct LocalMapper: Mapper {
  public typealias Response = (model: MovieModel, detail: CDMovieFavorite)
  public typealias Entity = (model: MovieModel, detail: DetailEntity)
  public typealias Domain = DetailModel

  public func transformResponseToEntity(response: (model: MovieModel, detail: CDMovieFavorite)) -> (model: MovieModel, detail: DetailEntity) {
    (
      response.model,
      DetailEntity(
        tagline: response.detail.tagline,
        status: response.detail.status,
        runtime: response.detail.runtime,
        genres: response.detail.genres ?? ["-"],
        language: response.detail.language ?? "-"
      )
    )
  }

  public func transformEntityToDomain(entity: (model: MovieModel, detail: DetailEntity)) -> DetailModel {
    DetailModel(
      idMovie: entity.model.idMovie,
      title: entity.model.title,
      overview: entity.model.overview,
      releaseDate: entity.model.releaseDate,
      genres: entity.model.genres.isEmpty ? entity.detail.genres : entity.model.genres,
      popularity: entity.model.popularity,
      rating: entity.model.rating,
      backdropPath: entity.model.backdropPath,
      posterPath: entity.model.posterPath,
      tagline: entity.detail.tagline == "" ? "Not Available" : entity.detail.tagline ?? "Not Available",
      status: entity.detail.status ?? "Unknown",
      runtime: entity.detail.runtime.flatMap { Int($0) }?.convertToDurationFormat() ?? "Not Available",
      language: entity.detail.language ?? "-"
    )
  }

  public func transformDomainToEntity(domain: DetailModel) -> (model: MovieModel, detail: DetailEntity) {
    (
    MovieModel(
      idMovie: domain.idMovie,
      title: domain.title,
      overview: domain.overview,
      releaseDate: domain.releaseDate,
      genres: domain.genres,
      popularity: domain.popularity,
      rating: domain.rating,
      backdropPath: domain.backdropPath,
      posterPath: domain.posterPath
    ),
    DetailEntity(
      tagline: domain.tagline,
      status: domain.status,
      runtime: domain.runtime.durationToInt().flatMap { Int16($0)},
      genres: domain.genres,
      language: domain.language
    )
    )
  }

  public init() { }
}
