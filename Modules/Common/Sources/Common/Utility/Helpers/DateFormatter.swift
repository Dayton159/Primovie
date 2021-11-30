//
//  DateFormatter.swift
//  
//
//  Created by Dayton on 30/11/21.
//

import Foundation

public extension Foundation.DateFormatter {
  @nonobjc static var standardDateFormatter: Foundation.DateFormatter = {
    let dateFormatter = Foundation.DateFormatter()
    return dateFormatter
  }()

  static func dateFormatter(_ format: String) -> Foundation.DateFormatter {
    let dateFormatter = standardDateFormatter
    dateFormatter.dateFormat = format
    return dateFormatter
  }
}

public enum DateFormatter {
  case JSONResponse
  case yearOnBack

  func formatter() -> Foundation.DateFormatter {
    switch self {
    case .JSONResponse:
      return dateFormatter(string: "yyyy-MM-dd")
    case .yearOnBack:
      return dateFormatter(string: "dd MMM yyyy")
    }
  }

  private func dateFormatter(string: String) -> Foundation.DateFormatter {
    let localFormatter = Foundation.DateFormatter.dateFormatter(string)
    localFormatter.locale = Locale.current
    return localFormatter
  }

  public func stringFromDate(_ date: Date?) -> String? {
    guard let safeDate = date else { return nil }
    return self.formatter().string(from: safeDate)
  }

  public func dateFromString(_ string: String) -> Date? {
    return self.formatter().date(from: string)
  }
}
