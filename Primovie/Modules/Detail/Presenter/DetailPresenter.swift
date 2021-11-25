//
//  DetailPresenter.swift
//  Primovie
//
//  Created by Dayton on 10/11/21.
//

import UIKit
import RxSwift
import RxCocoa

enum DataRequestSource {
  case network
  case local
}

class DetailPresenter: BasePresenter {
  private let interactor: DetailUseCase
  private let request: DataRequestSource
  private var detailMovie = BehaviorRelay<DetailModel?>(value: nil)
  private var isFavorite = PublishSubject<Bool>()

  init(interactor: DetailUseCase, request: DataRequestSource) {
    self.interactor = interactor
    self.request = request
  }

  var detailMovieObs: Observable<DetailModel?> {
    return detailMovie.asObservable()
  }

  var isFavoriteObs: Observable<Bool> {
    return isFavorite.asObservable()
  }

  func configureCell(cell: PropertyPosterTableViewCell) {
    guard let model = self.detailMovie.value else { return }
    cell.configureCell(detail: model)
  }

  func configureCell(cell: TitleGenreTableViewCell) {
    guard let model = self.detailMovie.value else { return }
    cell.configureCell(detail: model)
  }

  func configureCell(cell: ContentTableViewCell) {
    guard let model = self.detailMovie.value else { return }
    cell.configureCell(detail: model)
  }
}

extension DetailPresenter {
  func getMovieDetail() {
    self.state.onNext(.loading)
    self.interactor.getMovieDetail(source: request)
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
    self.interactor.saveMovieToFavorite(model: model)
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
    self.interactor.deleteFavoriteMovie()
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
    self.interactor.isMovieFavorited()
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
