//
//  MockAPIRequest.swift
//  
//
//  Created by Dayton on 29/11/21.
//

import Foundation
@testable import Common

public struct MockAPIRequest: APIRequest {
  public typealias Response = MockResponse

  public var pathname: String { "path/name" }
}
