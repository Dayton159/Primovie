//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import UIKit

public extension String {
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
}
