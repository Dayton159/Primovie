//
//  UIStackView+Extension.swift
//  Primovie
//
//  Created by Dayton on 12/11/21.
//

import UIKit

extension UIStackView {
  private func remove(view: UIView) {
    removeArrangedSubview(view)
    view.removeFromSuperview()
  }

  private func refresh() {
    self.arrangedSubviews.forEach { (view) in
      remove(view: view)
    }
  }

  func setGenreValue(with labels: [UILabel]) {
    self.refresh()
    labels.forEach {
      self.addArrangedSubview($0)
    }
  }
}
