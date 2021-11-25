//
//  HomePresenter.swift
//  Primovie
//
//  Created by Dayton on 10/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomePresenter: BasePresenter {
  private let interactor: HomeUseCase
  private var vc: UIViewController?
  private var nowPlayingMovies = BehaviorRelay<[MovieModel]>(value: [])
  private var topRatedMovies = BehaviorRelay<[MovieModel]>(value: [])
  private var didSelectMovie = PublishSubject<MovieModel>()
  private let router = HomeRouter()

  init(interactor: HomeUseCase) {
    self.interactor = interactor
  }

  var nowPlayingMoviesObs: Observable<[MovieModel]> {
    return nowPlayingMovies.asObservable()
  }

  var topRatedMoviesObs: Observable<[MovieModel]> {
    return topRatedMovies.asObservable()
  }

  var didSelectMovieObs: Observable<MovieModel> {
    return didSelectMovie.asObservable()
  }

  private func getNowPlayMovie(at indexPath: IndexPath) -> MovieModel {
    return self.nowPlayingMovies.value[indexPath.row]
  }

  private func getTopRatedMovie(at indexPath: IndexPath) -> MovieModel {
    return self.topRatedMovies.value[indexPath.row]
  }

  func configureCell(cell: NowPlayingCollectionViewCell, _ indexPath: IndexPath) {
    guard nowPlayingMovies.value.count != 0 else { return }
    let movie = self.getNowPlayMovie(at: indexPath)
    cell.configureCell(model: movie)
  }

  func configureCell(cell: TopRatedCollectionViewCell, _ indexPath: IndexPath) {
    guard topRatedMovies.value.count != 0 else { return }
    let movie = self.getTopRatedMovie(at: indexPath)
    cell.configureCell(model: movie)
  }

  func goToDetail(movie: MovieModel) {
    let detailView = router.makeDetailView(movie: movie)
    detailView.hidesBottomBarWhenPushed = true
    self.vc?.show(detailView, sender: vc)
  }

  func setViewController(_ vc: UIViewController) {
    self.vc = vc
  }
}

extension HomePresenter {
  func getNowPlayingMovies() {
    self.state.onNext(.loading)
    self.interactor.getNowPlayingMovies()
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] movie in
        guard let self = self else { return }
        self.nowPlayingMovies.accept(movie)
        self.state.onNext(.finish)
      }, onFailure: { [weak self] error in
        guard let self = self,
        let errorDesc = error.asAFError?.errorDescription
        else { return }
        self.state.onNext(.error)
        self.error.onNext(errorDesc)
      }).disposed(by: disposeBag)
  }

  func getTopRatedMovies() {
    self.state.onNext(.loading)
    self.interactor.getTopRatedMovies()
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] movie in
        guard let self = self else { return }
        self.topRatedMovies.accept(movie)
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
