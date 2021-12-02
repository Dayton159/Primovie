//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import Common
import RxSwift
import RxCocoa

public class DetailPresenter<
  DetailUseCase: UseCase,
  SaveUseCase: UseCase,
  DeleteUseCase: UseCase,
  IsFavUseCase: UseCase>: BasePresenter
where DetailUseCase.Request == DataRequestSource,
DetailUseCase.Response == DetailModel,
SaveUseCase.Request == DetailModel,
SaveUseCase.Response == Void,
DeleteUseCase.Request == Any,
DeleteUseCase.Response == Void,
IsFavUseCase.Request == Any,
IsFavUseCase.Response == Bool {

  private let _detailUseCase: DetailUseCase
  private let _saveUseCase: SaveUseCase
  private let _deleteUseCase: DeleteUseCase
  private let _isFavUseCase: IsFavUseCase
  private let _request: DataRequestSource

  public init(
    detailUseCase: DetailUseCase,
    saveUseCase: SaveUseCase,
    deleteUseCase: DeleteUseCase,
    isFavUseCase: IsFavUseCase,
    request: DataRequestSource
  ) {
    _detailUseCase = detailUseCase
    _saveUseCase = saveUseCase
    _deleteUseCase = deleteUseCase
    _isFavUseCase = isFavUseCase
    _request = request
  }

  private let detailMovie = BehaviorRelay<DetailModel?>(value: nil)
  private var isFavorite = PublishSubject<Bool>()

  public var detailMovieObs: Observable<DetailModel?> {
    return detailMovie.asObservable()
  }

  public var isFavoriteObs: Observable<Bool> {
    return isFavorite.asObservable()
  }

  public var detailItem: DetailModel {
    return detailMovie.value ?? DetailModel.sample
  }
}

public extension DetailPresenter {
  func getMovieDetail() {
    self.state.onNext(.loading)
    self._detailUseCase.execute(request: _request)
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] detail in
        guard let self = self else { return }
        self.detailMovie.accept(detail)
        self.state.onNext(.finish)
      }, onFailure: { [weak self] error in
        guard let self = self else { return }
        self.state.onNext(.error)
        self.error.onNext(error.asAFError?.errorDescription ?? error.localizedDescription)
      }).disposed(by: disposeBag)
  }

  func saveMovieToFavorite() {
    guard let model = detailMovie.value else { return }
    self.state.onNext(.loading)
    self._saveUseCase.execute(request: model)
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] _ in
        guard let self = self else { return }
        self.isFavorite.onNext(true)
        self.state.onNext(.finish)
      }, onFailure: { [weak self] error in
        guard let self = self else { return }
        self.state.onNext(.error)
        self.error.onNext(error.localizedDescription)
      }).disposed(by: disposeBag)
  }

  func deleteFavoriteMovie() {
    self.state.onNext(.loading)
    self._deleteUseCase.execute(request: nil)
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] _ in
        guard let self = self else { return }
        self.isFavorite.onNext(false)
        self.state.onNext(.finish)
      }, onFailure: { [weak self] error in
        guard let self = self else { return }
        self.state.onNext(.error)
        self.error.onNext(error.localizedDescription)
      }).disposed(by: disposeBag)
  }

  func isMovieFavorited() {
    self._isFavUseCase.execute(request: nil)
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] favorite in
        guard let self = self else { return }
        self.isFavorite.onNext(favorite)
      }, onFailure: { [weak self] error in
        guard let self = self else { return }
        self.error.onNext(error.localizedDescription)
      }).disposed(by: disposeBag)
  }
}
