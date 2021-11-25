//
//  Double+Extension.swift
//  Primovie
//
//  Created by Dayton on 09/11/21.
//

extension Double {
  func toString(digit: Int = 1) -> String? {
    return String(format: "%.\(digit)f", self)
  }
}
