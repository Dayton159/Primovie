//
//  MovieListRepository.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Primovie_Core
import Common
import RxSwift

public struct MovieListRepository<
  ExploreDataSource: DataSource,
  Transformer: Mapper>: Repository
where ExploreDataSource.Request == String,
      ExploreDataSource.Response == [MovieResponse],
      Transformer.Response == [MovieResponse],
      Transformer.Entity == [MovieEntity],
      Transformer.Domain == [MovieModel] {

  public typealias Request = String
  public typealias Response = [MovieModel]

  private let _dataSource: ExploreDataSource
  private let _mapper: Transformer

  public init(remote: ExploreDataSource, mapper: Transformer) {
    _dataSource = remote
    _mapper = mapper
  }

  public func execute(request: String?) -> Single<[MovieModel]> {
    self._dataSource.execute(request: request)
      .map { _mapper.transformResponseToEntity(response: $0)}
      .map { _mapper.transformEntityToDomain(entity: $0)}
  }
}
