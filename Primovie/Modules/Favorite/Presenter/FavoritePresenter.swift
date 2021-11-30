//
//  FavoritePresenter.swift
//  Primovie
//
//  Created by Dayton on 10/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritePresenter: BasePresenter {
  private let interactor: FavoriteUseCase
  private var vc: UIViewController?
  private var favoriteMovies = BehaviorRelay<[MovieModel]>(value: [])
  private let router = FavoriteRouter()

  init(interactor: FavoriteUseCase) {
    self.interactor = interactor
  }

  var favoriteMoviesObs: Observable<[MovieModel]> {
    return favoriteMovies.asObservable()
  }

  var getNumberOfMovie: Int {
    return favoriteMovies.value.count
  }

  func configureCell(cell: MovieListTableViewCell, _ indexPath: IndexPath) {
    let movie = self.getMovieAt(indexPath)
    cell.configureCell(data: movie)
  }

  private func getMovieAt(_ indexPath: IndexPath) -> MovieModel {
    return self.favoriteMovies.value[indexPath.row]
  }

  func goToDetail(_ indexPath: IndexPath) {
    let movie = self.getMovieAt(indexPath)
    let detailView = router.makeDetailView(movie: movie)
    detailView.hidesBottomBarWhenPushed = true
    self.vc?.show(detailView, sender: vc)
  }

  func goToAbout() {
    let about = router.makeAboutView()
    about.hidesBottomBarWhenPushed = true
    self.vc?.show(about, sender: vc)
  }

  func setViewController(_ vc: UIViewController) {
    self.vc = vc
  }
}

extension FavoritePresenter {
  func getFavoriteMovies() {
    self.state.onNext(.loading)
    self.interactor.getFavoriteMovies()
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] movie in
        guard let self = self else { return }
        self.favoriteMovies.accept(movie)
        self.state.onNext(.finish)
      }, onFailure: { [weak self] error in
        guard let self = self else { return }
        self.state.onNext(.error)
        self.error.onNext(error.localizedDescription)
      }).disposed(by: disposeBag)
  }
}
