//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import Common
import RxSwift

public struct SaveRepository<
  SaveDataSource: LocaleDataSource,
  Transformer: Mapper>: Repository
where SaveDataSource.Request == (movie: MovieEntity, detail: DetailEntity),
      SaveDataSource.Response == Void,
      Transformer.Response == CDMovieFavorite,
      Transformer.Entity == (movie: MovieEntity, detail: DetailEntity),
      Transformer.Domain == DetailModel {

  public typealias Request = DetailModel
  public typealias Response = Void

  private let _dataSource: SaveDataSource
  private let _mapper: Transformer

  public init(local: SaveDataSource, mapper: Transformer) {
    _dataSource = local
    _mapper = mapper
  }

  public func execute(request: DetailModel?) -> Single<Void> {
    let entity = _mapper.transformDomainToEntity(domain: request ?? DetailModel.sampleLocal)
   return _dataSource.execute(request: entity)
  }
}
