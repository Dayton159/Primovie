//
//  Int+Extension.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

extension Int {
  func convertToDurationFormat() -> String {
    let time = (hour: self / 60, minute: self % 60)
    return "\(time.hour)h \(time.minute)m"
  }
}
