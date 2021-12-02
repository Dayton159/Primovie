//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import Common

public struct SaveMapper: Mapper {
  public typealias Response = CDMovieFavorite
  public typealias Entity = (movie: MovieEntity, detail: DetailEntity)
  public typealias Domain = DetailModel

  public func transformResponseToEntity(response: CDMovieFavorite) -> (movie: MovieEntity, detail: DetailEntity) {
    (
      MovieEntity(
        idMovie: response.idMovie,
        title: response.title,
        overview: response.overview,
        releaseDate: response.releaseDate,
        genres: response.genres ?? [],
        popularity: response.popularity,
        rating: response.rating,
        backdropPath: response.backdropPath,
        posterPath: response.posterPath
      ),
      DetailEntity(
        tagline: response.tagline,
        status: response.status,
        runtime: response.runtime,
        genres: response.genres ?? ["-"],
        language: response.language ?? "-"
      )
    )
  }

  public func transformEntityToDomain(entity: (movie: MovieEntity, detail: DetailEntity)) -> DetailModel {
    DetailModel(
      idMovie: Int(entity.movie.idMovie ?? 0),
      title: entity.movie.title ?? "-",
      overview: entity.movie.overview ?? "Not Available",
      releaseDate: DateFormatter.yearOnBack.stringFromDate(entity.movie.releaseDate) ?? "Unknown",
      genres: entity.movie.genres,
      popularity: entity.movie.popularity?.toString() ?? "-",
      rating: entity.movie.rating?.toString() ?? "-",
      backdropPath: entity.movie.backdropPath ?? "",
      posterPath: entity.movie.posterPath ?? "",
      tagline: entity.detail.tagline == "" ? "Not Available" : entity.detail.tagline ?? "Not Available",
      status: entity.detail.status ?? "Unknown",
      runtime: entity.detail.runtime.flatMap { Int($0) }?.convertToDurationFormat() ?? "Not Available",
      language: entity.detail.language ?? "-")
  }

  public func transformDomainToEntity(domain: DetailModel) -> (movie: MovieEntity, detail: DetailEntity) {
    (
      MovieEntity(
        idMovie: Int64(domain.idMovie),
        title: domain.title,
        overview: domain.overview,
        releaseDate: DateFormatter.yearOnBack.dateFromString(domain.releaseDate),
        genres: [],
        popularity: Double(domain.popularity),
        rating: Double(domain.rating),
        backdropPath: domain.backdropPath,
        posterPath: domain.posterPath)
      ,
      DetailEntity(
        tagline: domain.tagline,
        status: domain.status,
        runtime: domain.runtime.durationToInt().flatMap { Int16($0)},
        genres: domain.genres,
        language: domain.language)
    )
  }
}
