//
//  Constants.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

import UIKit

struct Constants {
  struct Image {
    // Tab Icon
    static let homeTab = UIImage(systemName: "tv")
    static let homeTabSelected = UIImage(systemName: "tv.fill")

    static let exploreTab = UIImage(systemName: "lightbulb")
    static let exploreTabSelected = UIImage(systemName: "lightbulb.fill")

    static let favTab = UIImage(systemName: "heart")
    static let favTabSelected = UIImage(systemName: "heart.fill")

    // Placeholder
    static let placeholder = UIImage(named: "image_default")

    // Navigation Item
    static let bookmark = UIImage(systemName: "bookmark")
    static let bookmarkFill = UIImage(systemName: "bookmark.fill")
    static let profile = UIImage(systemName: "person.crop.circle")
  }

  struct Color {
    static let genre = UIColor(named: "star")
  }

  struct Font {
    static func regular(_ size: CGFloat = 12) -> UIFont {
      guard let font = UIFont(name: "Lato-Regular", size: size) else { fatalError("Lato-Regular Not Found")}
      return font
    }

    static func semibold(_ size: CGFloat = 12) -> UIFont {
      guard let font = UIFont(name: "Lato-Semibold", size: size) else { fatalError("Lato-Semibold Not Found")}
      return font
    }

    static func bold(_ size: CGFloat = 12) -> UIFont {
      guard let font = UIFont(name: "Lato-Bold", size: size) else { fatalError("Lato-Bold Not Found")}
      return font
    }
  }
}
