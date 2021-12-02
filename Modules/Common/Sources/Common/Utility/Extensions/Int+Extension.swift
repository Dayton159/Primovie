//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

public extension Int {
  func convertToDurationFormat() -> String {
    let time = (hour: self / 60, minute: self % 60)
    return "\(time.hour)h \(time.minute)m"
  }
}
