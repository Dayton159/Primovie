//
//  ExplorePresenter.swift
//  Primovie
//
//  Created by Dayton on 10/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class ExplorePresenter: BasePresenter {
  private let interactor: ExploreUseCase
  private var vc: UIViewController?
  private var movieList = BehaviorRelay<[MovieModel]>(value: [])
  private let router = ExploreRouter()

  init(interactor: ExploreUseCase) {
    self.interactor = interactor
  }

  var movieListObs: Observable<[MovieModel]> {
    return movieList.asObservable()
  }

  var getNumberOfMovie: Int {
    return movieList.value.count
  }

  func configureCell(cell: MovieListTableViewCell, _ indexPath: IndexPath) {
    let movie = self.getMovieAt(indexPath)
    cell.configureCell(data: movie)
  }

  private func getMovieAt(_ indexPath: IndexPath) -> MovieModel {
    return self.movieList.value[indexPath.row]
  }

  func goToDetail(_ indexPath: IndexPath) {
    let movie = self.getMovieAt(indexPath)
    let detailView = router.makeDetailView(movie: movie)
    detailView.hidesBottomBarWhenPushed = true
    self.vc?.show(detailView, sender: vc)
  }

  func setViewController(_ vc: UIViewController) {
    self.vc = vc
  }
}

extension ExplorePresenter {
  func getPopularMovies() {
    self.state.onNext(.loading)
    self.interactor.getPopularMovies()
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] movie in
        guard let self = self else { return }
        self.movieList.accept(movie)
        self.state.onNext(.finish)
      }, onFailure: { [weak self] error in
        guard let self = self,
        let errorDesc = error.asAFError?.errorDescription
        else { return }
        self.state.onNext(.error)
        self.error.onNext(errorDesc)
      }).disposed(by: disposeBag)
  }

  func getMovieLists(by keyword: String) {
    self.state.onNext(.loading)
    self.interactor.getMovieLists(by: keyword)
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] movie in
        guard let self = self else { return }
        self.movieList.accept(movie)
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
