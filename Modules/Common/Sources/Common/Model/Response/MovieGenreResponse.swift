//
//  File.swift
//  
//
//  Created by Dayton on 29/11/21.
//

public struct MovieGenreResponse: Codable, Equatable {
  public let genres: [Genre]
}

public struct Genre: Codable, Equatable {
  public let id: Int
  public let name: String
}
