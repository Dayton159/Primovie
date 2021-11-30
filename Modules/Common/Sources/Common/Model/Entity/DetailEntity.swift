//
//  DetailEntity.swift
//  
//
//  Created by Dayton on 29/11/21.
//

public struct DetailEntity {
  public let tagline: String?
  public let status: String?
  public let runtime: Int16?
  public let genres: [String]
  public let language: String?

  public init(
    tagline: String?,
    status: String?,
    runtime: Int16?,
    genres: [String],
    language: String?
  ) {
    self.tagline = tagline
    self.status = status
    self.runtime = runtime
    self.genres = genres
    self.language = language
  }
}
