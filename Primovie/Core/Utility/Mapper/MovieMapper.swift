//
//  MovieMapper.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

final class MovieMapper {

  static func mapMovieResponsesToEntity(movie response: [MovieResponse], genre: [String] = []) -> [MovieEntity] {
    return response.map {
       MovieEntity(
        idMovie: $0.idMovie.flatMap { Int64($0) },
        title: $0.title,
        overview: $0.overview,
        releaseDate: DateFormatter.JSONResponse.dateFromString($0.releaseDate ?? ""),
        genres: genre,
        popularity: $0.popularity,
        rating: $0.rating,
        backdropPath: $0.backdropPath,
        posterPath: $0.posterPath
      )
    }
  }

  static func mapDetailMovieResponseToEntity(detail response: DetailMovieResponse) -> DetailEntity {
    return DetailEntity(
      tagline: response.tagline,
      status: response.status,
      runtime: response.runtime.flatMap { Int16($0) },
      genres: response.genres.map { $0.name },
      language: response.language.map { $0.name }.first
    )
  }

  static func mapMovieEntityToDomain(movie entity: [MovieEntity]) -> [MovieModel] {
    return entity.map {
      MovieModel(
        idMovie: Int($0.idMovie ?? 0),
        title: $0.title ?? "-",
        overview: $0.overview ?? "Not Available",
        releaseDate: DateFormatter.yearOnBack.stringFromDate($0.releaseDate) ?? "Unknown",
        genres: $0.genres,
        popularity: $0.popularity?.toString() ?? "-",
        rating: $0.rating?.toString() ?? "-",
        backdropPath: $0.backdropPath ?? "",
        posterPath: $0.posterPath ?? ""
      )
    }
  }

  static func mapDetailMovieToDomain(movie model: MovieModel, detail entity: DetailEntity) -> DetailModel {
    DetailModel(
      idMovie: model.idMovie,
      title: model.title,
      overview: model.overview,
      releaseDate: model.releaseDate,
      genres: model.genres.isEmpty ? entity.genres : model.genres,
      popularity: model.popularity,
      rating: model.rating,
      backdropPath: model.backdropPath,
      posterPath: model.posterPath,
      tagline: entity.tagline == "" ? "Not Available" : entity.tagline ?? "Not Available",
      status: entity.status ?? "Unknown",
      runtime: entity.runtime.flatMap { Int($0) }?.convertToDurationFormat() ?? "Not Available",
      language: entity.language ?? "-"
    )
  }

  static func mapMovieCDToEntity(object data: [MovieFavorite]) -> [MovieEntity] {
    return data.map {
      MovieEntity(
        idMovie: $0.idMovie,
        title: $0.title,
        overview: $0.overview,
        releaseDate: $0.releaseDate,
        genres: $0.genres ?? [],
        popularity: $0.popularity,
        rating: $0.rating,
        backdropPath: $0.backdropPath,
        posterPath: $0.posterPath
      )
    }
  }

  static func mapDetailCDToEntity(object data: MovieFavorite) -> DetailEntity {
    DetailEntity(
      tagline: data.tagline,
      status: data.status,
      runtime: data.runtime,
      genres: data.genres ?? ["-"],
      language: data.language ?? "-"
    )
  }

  static func mapDetailModelToEntity(detail model: DetailModel) -> (movie: MovieEntity, detail: DetailEntity) {
    return (
    MovieEntity(
      idMovie: Int64(model.idMovie),
      title: model.title,
      overview: model.overview,
      releaseDate: DateFormatter.yearOnBack.dateFromString(model.releaseDate),
      genres: [],
      popularity: Double(model.popularity),
      rating: Double(model.rating),
      backdropPath: model.backdropPath,
      posterPath: model.posterPath)
    ,
    DetailEntity(
      tagline: model.tagline,
      status: model.status,
      runtime: model.runtime.durationToInt().flatMap { Int16($0)},
      genres: model.genres,
      language: model.language)
    )
  }
}
