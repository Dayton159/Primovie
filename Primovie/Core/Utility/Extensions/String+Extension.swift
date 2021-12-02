//
//  String+Extension.swift
//  Primovie
//
//  Created by Dayton on 10/11/21.
//

import UIKit

extension String {
  func makeGenreLabel() -> UILabel {
    let label = UILabel()
    label.font = Constants.Font.regular(13)
    label.backgroundColor = Constants.Color.genre
    label.layer.masksToBounds = true
    label.cornerRadius = 13
    label.text = self
    label.textAlignment = .center
    label.textColor = .black
    return label
  }
}
