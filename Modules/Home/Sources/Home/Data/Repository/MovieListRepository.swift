//
//  MovieListRepository.swift
//  
//
//  Created by Dayton on 29/11/21.
//

import Primovie_Core
import Common
import RxSwift

public struct MovieListRepository<
  HomeDataSource: DataSource,
  Transformer: Mapper>: Repository
where HomeDataSource.Request == MovieRequest,
      HomeDataSource.Response == [MovieResponse],
      Transformer.Response == (response: [MovieResponse], genre: [String]),
      Transformer.Entity == [MovieEntity],
      Transformer.Domain == [MovieModel] {

  public typealias Request = MovieRequest
  public typealias Response = [MovieModel]

  private let _dataSource: HomeDataSource
  private let _mapper: Transformer

  public init(remote: HomeDataSource, mapper: Transformer) {
    _dataSource = remote
    _mapper = mapper
  }

  public func execute(request: MovieRequest?) -> Single<[MovieModel]> {
    if request == .nowPlaying, let homeDS = _dataSource as? MovieListDataSource {
     return self._dataSource.execute(request: request)
        .flatMap { response in
          homeDS.getGenre()
            .map {
              $0.filter { response.flatMap { $0.genreIDs }.contains($0.id)}
              .map { $0.name }
            }
            .map {
              _mapper.transformResponseToEntity(response: (response, $0))
            }
        }
        .map { _mapper.transformEntityToDomain(entity: $0)}
    } else {
      return self._dataSource.execute(request: request)
        .map { _mapper.transformResponseToEntity(response: ($0, []))}
        .map { _mapper.transformEntityToDomain(entity: $0)}
    }
  }
}
