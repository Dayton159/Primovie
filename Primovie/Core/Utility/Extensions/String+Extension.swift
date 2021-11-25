//
//  String+Extension.swift
//  Primovie
//
//  Created by Dayton on 10/11/21.
//

import UIKit

extension String {
  func durationToInt() -> Int? {
    guard let hourIndex = self.firstIndex(of: "h"),
          let minuteIndex = self.firstIndex(of: "m")
    else { return nil }

    let hourRange = self.index(self.startIndex, offsetBy: 0) ..< hourIndex
    let minuteRange = self.index(hourIndex, offsetBy: 2) ..< minuteIndex

    guard let hourValue = Int(String(self[hourRange])),
          let minuteValue = Int(String(self[minuteRange]))
    else { return nil}

    return (hourValue * 60) + minuteValue
  }

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
