//
//  UITabBarController+Extension.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

import UIKit

extension UITabBarController {
  func setTabBarTintColor(color: UIColor) {
    if #available(iOS 15.0, *) {
       let appearance = UITabBarAppearance()
       appearance.configureWithOpaqueBackground()
       appearance.backgroundColor = color

      tabBar.standardAppearance = appearance
      tabBar.scrollEdgeAppearance = appearance
    } else {
      self.tabBar.barTintColor = color
    }
  }
}
