//
//  HomePresenter.swift
//  
//
//  Created by Dayton on 30/11/21.
//

import Primovie_Core
import Common
import RxSwift
import RxCocoa

public class HomePresenter<HomeUseCase: UseCase>: BasePresenter
where HomeUseCase.Request == MovieRequest,
      HomeUseCase.Response == [MovieModel] {

  private let _useCase: HomeUseCase
  private var nowPlaying = BehaviorRelay<[MovieModel]>(value: [])
  private var topRated = BehaviorRelay<[MovieModel]>(value: [])

  public var nowPlayingObs: Observable<[MovieModel]> {
    return nowPlaying.asObservable()
  }

  public var topRatedObs: Observable<[MovieModel]> {
    return topRated.asObservable()
  }

  public init(useCase: HomeUseCase) {
    self._useCase = useCase
    super.init()
  }

  public func getMovies(_ request: HomeUseCase.Request) {
    self.state.onNext(.loading)
    self._useCase.execute(request: request)
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] movie in
        guard let self = self else { return }
        switch request {
        case .nowPlaying:
          self.nowPlaying.accept(movie)
        case .topRated:
          self.topRated.accept(movie)
        }
        self.state.onNext(.finish)
      }, onFailure: { [weak self] error in
        guard let self = self,
              let errorDesc = error.asAFError?.errorDescription
        else { return }
        self.state.onNext(.error)
        self.error.onNext(errorDesc)
      }).disposed(by: disposeBag)
  }
}
