//
//  Double+Extension.swift
//  
//
//  Created by Dayton on 30/11/21.
//

public extension Double {
  func toString(digit: Int = 1) -> String? {
    return String(format: "%.\(digit)f", self)
  }
}
