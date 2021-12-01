//
//  FavoritesMapper.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Primovie_Core
import Common

public struct FavoritesMapper: Mapper {
  public typealias Response = [CDMovieFavorite]
  public typealias Entity = [MovieEntity]
  public typealias Domain = [MovieModel]

  public func transformResponseToEntity(response: [CDMovieFavorite]) -> [MovieEntity] {
    return response.map {
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

  public func transformEntityToDomain(entity: [MovieEntity]) -> [MovieModel] {
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

  public func transformDomainToEntity(domain: [MovieModel]) -> [MovieEntity] {
    return domain.map {
      MovieEntity(
       idMovie: Int64($0.idMovie),
       title: $0.title,
       overview: $0.overview,
       releaseDate: DateFormatter.JSONResponse.dateFromString($0.releaseDate),
       genres: $0.genres,
       popularity: Double($0.popularity),
       rating: Double($0.rating),
       backdropPath: $0.backdropPath,
       posterPath: $0.posterPath
     )
    }
  }

  public init() { }
}
