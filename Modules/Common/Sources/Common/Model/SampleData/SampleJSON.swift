//
//  File.swift
//  
//
//  Created by Dayton on 30/11/21.
//

import Foundation

public struct SampleJSON {
  public static let list = """
{
  "results": [
      {
          "adult": false,
          "backdrop_path": "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg",
          "genre_ids": [
              28,
              12,
              14
          ],
          "id": 566525,
          "original_language": "en",
          "original_title": "Shang-Chi and the Legend of the Ten Rings",
          "overview": "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.",
          "popularity": 5098.495,
          "poster_path": "/xeItgLK9qcafxbd8kYgv7XnMEog.jpg",
          "release_date": "2021-09-01",
          "title": "Shang-Chi and the Legend of the Ten Rings",
          "video": false,
          "vote_average": 7.9,
          "vote_count": 2294
      },
      {
          "adult": false,
          "backdrop_path": "/efuPybo8V8KTYGslQphO74LRvm0.jpg",
          "genre_ids": [
              878,
              28,
              12
          ],
          "id": 580489,
          "original_language": "en",
          "original_title": "Venom: Let There Be Carnage",
          "overview": "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
          "popularity": 4813.544,
          "poster_path": "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg",
          "release_date": "2021-09-30",
          "title": "Venom: Let There Be Carnage",
          "video": false,
          "vote_average": 6.8,
          "vote_count": 1851
      },
      {
          "adult": false,
          "backdrop_path": "/fzKWwcaam9QSTaMSJlORuSojxio.jpg",
          "genre_ids": [
              28,
              12,
              878
          ],
          "id": 524434,
          "original_language": "en",
          "original_title": "Eternals",
          "overview": "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind???s most ancient enemy, the Deviants.",
          "popularity": 2460.836,
          "poster_path": "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg",
          "release_date": "2021-11-03",
          "title": "Eternals",
          "video": false,
          "vote_average": 7.2,
          "vote_count": 843
      }
  ]
}
"""

 public static let detail = """
  {
      "genres": [
          {
              "id": 35,
              "name": "Science Fiction"
          },
          {
              "id": 80,
              "name": "Action"
          },
          {
              "id": 80,
              "name": "Adventure"
          }
      ],
      "runtime": 97,
      "spoken_languages": [
          {
              "english_name": "English",
              "iso_639_1": "en",
              "name": "English"
          }
      ],
      "status": "Released",
      "tagline": "Not Available",
  }
  """

  public static let genre = """
{
    "genres": [
        {
            "id": 28,
            "name": "Action"
        },
        {
            "id": 12,
            "name": "Adventure"
        },
        {
            "id": 16,
            "name": "Animation"
        },
        {
            "id": 35,
            "name": "Comedy"
        },
        {
            "id": 80,
            "name": "Crime"
        },
        {
            "id": 99,
            "name": "Documentary"
        },
        {
            "id": 18,
            "name": "Drama"
        },
        {
            "id": 10751,
            "name": "Family"
        },
        {
            "id": 14,
            "name": "Fantasy"
        },
        {
            "id": 36,
            "name": "History"
        },
        {
            "id": 27,
            "name": "Horror"
        },
        {
            "id": 10402,
            "name": "Music"
        },
        {
            "id": 9648,
            "name": "Mystery"
        },
        {
            "id": 10749,
            "name": "Romance"
        },
        {
            "id": 878,
            "name": "Science Fiction"
        },
        {
            "id": 10770,
            "name": "TV Movie"
        },
        {
            "id": 53,
            "name": "Thriller"
        },
        {
            "id": 10752,
            "name": "War"
        },
        {
            "id": 37,
            "name": "Western"
        }
    ]
}
"""

  public init() { }
}
