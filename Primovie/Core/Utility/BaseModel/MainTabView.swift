//
//  MainView.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

import UIKit

class MainTabView: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    configureTabBar()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  // MARK: - Configuration

  private func configureTabBar() {
    self.tabBar.clipsToBounds = false
    self.tabBar.tintColor = .black
    self.tabBar.accessibilityIgnoresInvertColors = true
    self.tabBar.isTranslucent = false
    self.setTabBarTintColor(color: .white)
  }

  func makeNavigationItem(title: String, icon: (default: UIImage, selected: UIImage), vc rootViewController: UIViewController) -> UINavigationController {

    let navigation = UINavigationController(rootViewController: rootViewController)
    navigation.tabBarItem.image = icon.default
    navigation.tabBarItem.selectedImage = icon.selected
    navigation.tabBarItem.title = title

    return navigation
  }

}
