//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Primovie_Core
import Common
import RxSwift

public struct MovieListLocalRepository<
  FavoritesDataSource: LocaleDataSource,
  Transformer: Mapper>: Repository
where FavoritesDataSource.Request == Any,
      FavoritesDataSource.Response == [CDMovieFavorite],
      Transformer.Response == [CDMovieFavorite],
      Transformer.Entity == [MovieEntity],
      Transformer.Domain == [MovieModel] {

  public typealias Request = Any
  public typealias Response = [MovieModel]

  private let _dataSource: FavoritesDataSource
  private let _mapper: Transformer

  public init(remote: FavoritesDataSource, mapper: Transformer) {
    _dataSource = remote
    _mapper = mapper
  }

  public func execute(request: Any?) -> Single<[MovieModel]> {
    self._dataSource.execute(request: request)
      .map { _mapper.transformResponseToEntity(response: $0)}
      .map { _mapper.transformEntityToDomain(entity: $0)}
  }
}
