//
//  AppCoordinator.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

import UIKit
import Home
import Explore
import Favorite

class AppCoordinator {
  private let window: UIWindow
  private let mainView: MainTabView

  init(window: UIWindow, mainView: MainTabView) {
    self.window = window
    self.mainView = mainView
  }

  func start() {
    window.rootViewController = mainView
    self.setupViewController()
    window.makeKeyAndVisible()

    UIView.transition(with: window,
                      duration: 0.5,
                      options: .transitionCrossDissolve,
                      animations: nil,
                      completion: nil)
  }

  private func setupViewController() {
    mainView.viewControllers = [
      makeHome(),
      makeExplore(),
      makeFavorite()
    ]
  }

  private func makeHome() -> UIViewController {
    guard let home = Constants.Image.homeTab,
          let homeSelected = Constants.Image.homeTabSelected
    else { fatalError("Home Icons Not Found") }

    let useCase: HomeInteractor = Injection.init().provideHome()
    let presenter = HomePresenter(useCase: useCase)
    let homeView = HomeView(presenter: presenter)

    let homeNavVC = mainView.makeNavigationItem(
      title: "Home",
      icon: (home, homeSelected),
      vc: homeView
    )

    return homeNavVC
  }

  private func makeExplore() -> UIViewController {
    guard let explore = Constants.Image.exploreTab,
          let exploreSelected = Constants.Image.exploreTabSelected
    else { fatalError("Explore Icons Not Found") }

    let useCase: ExploreInteractor = Injection.init().provideExplore()
    let presenter = ExplorePresenter(useCase: useCase)
    let exploreView = ExploreView(presenter: presenter)

    let exploreNavVC = mainView.makeNavigationItem(
      title: "Explore",
      icon: (explore, exploreSelected),
      vc: exploreView
    )

    return exploreNavVC
  }

  private func makeFavorite() -> UIViewController {
    guard let favorite = Constants.Image.favTab,
          let favoriteSelected = Constants.Image.favTabSelected
    else { fatalError("Favorite Icons Not Found") }

    let useCase: FavoritesInteractor = Injection.init().provideFavorite()
    let presenter = FavoritesPresenter(useCase: useCase)
    let favoriteView = FavoriteView(presenter: presenter)

    let favoriteNavVC = mainView.makeNavigationItem(
      title: "Favorite",
      icon: (favorite, favoriteSelected),
      vc: favoriteView
    )

    return favoriteNavVC
  }
}
