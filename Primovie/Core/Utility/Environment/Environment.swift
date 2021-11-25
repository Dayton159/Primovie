//
//  Environment.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

import Foundation

private enum ConfigKeys: String {
  case baseURL = "BASE_URL"
  case apiKey = "API_KEY"
  case imageLoader = "IMAGE_LOADER_URL"
}

private final class PlistUtility {

  private init() {}

  static func getValue(from key: ConfigKeys) -> String {

    guard let info = Bundle.main.infoDictionary else {
      fatalError("Plist Not Found")
    }

    guard let value = info[key.rawValue] as? String else {
      fatalError("\(key)'s not set in Plist File")
    }

    return value
  }
}

enum Environment {
  static let baseURL = PlistUtility.getValue(from: ConfigKeys.baseURL)
  static let apiKey = PlistUtility.getValue(from: ConfigKeys.apiKey)
  static let imageLoaderURL = PlistUtility.getValue(from: ConfigKeys.imageLoader)
}
