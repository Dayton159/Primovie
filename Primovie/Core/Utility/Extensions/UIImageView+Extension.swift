//
//  UIImageView+Extension.swift
//  Primovie
//
//  Created by Dayton on 11/11/21.
//

import UIKit
import Kingfisher

extension UIImageView {
  func setImageFrom(path: String) {
    let urlString = Environment.imageLoaderURL + path
    let supportSpace = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    self.kf.setImage(with: convertToURL(urlString: supportSpace), placeholder: Constants.Image.placeholder, options: [.cacheMemoryOnly, .transition(.fade(0.5))])
  }

  private func convertToURL(urlString: String?) -> URL? {
    guard let safeUrlString = urlString,
          let url = URL(string: safeUrlString) else { return nil}
    return url
  }
}
