//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import Common
import RxSwift

public struct MovieRepository<
  RemoteDataSource: DataSource,
  LocalDataSource: LocaleDataSource,
  RemoteTransformer: Mapper,
  LocalTransformer: Mapper>: Repository
where RemoteDataSource.Request == Any,
      RemoteDataSource.Response == DetailMovieResponse,
      LocalDataSource.Request == Any,
      LocalDataSource.Response == CDMovieFavorite,
      RemoteTransformer.Response == (model: MovieModel, detail: DetailMovieResponse),
      RemoteTransformer.Entity == (model: MovieModel, detail: DetailEntity),
      RemoteTransformer.Domain == DetailModel,
      LocalTransformer.Response == (model: MovieModel, detail: CDMovieFavorite),
      LocalTransformer.Entity == (model: MovieModel, detail: DetailEntity),
      LocalTransformer.Domain == DetailModel {

  public typealias Request = DataRequestSource
  public typealias Response = DetailModel

  private let _remote: RemoteDataSource
  private let _local: LocalDataSource
  private let _mapperRemote: RemoteTransformer
  private let _mapperLocal: LocalTransformer
  private let _model: MovieModel

  public init(
    remote: RemoteDataSource,
    local: LocalDataSource,
    mapperRemote: RemoteTransformer,
    mapperLocal: LocalTransformer,
    model: MovieModel) {
    _remote = remote
    _local = local
    _mapperRemote = mapperRemote
    _mapperLocal = mapperLocal
    _model = model
  }

  public func execute(request: DataRequestSource?) -> Single<DetailModel> {
    switch request {
    case .local:
      return _local.execute(request: nil)
        .map { _mapperLocal.transformResponseToEntity(response: (_model, $0))}
        .map { _mapperLocal.transformEntityToDomain(entity: $0)}
    default:
      return _remote.execute(request: nil)
        .map { _mapperRemote.transformResponseToEntity(response: (_model, $0))}
        .map { _mapperRemote.transformEntityToDomain(entity: $0)}
    }
  }
}
