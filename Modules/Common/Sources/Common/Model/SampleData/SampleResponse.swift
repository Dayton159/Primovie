//
//  File.swift
//  
//
//  Created by Dayton on 30/11/21.
//

public extension MovieResponse {
  static var samples: [MovieResponse] {
    .init(
    [
      .init(
        posterPath: "/xeItgLK9qcafxbd8kYgv7XnMEog.jpg",
        overview: "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.",
        releaseDate: "2021-09-01",
        genreIDs: [28, 12, 14],
        idMovie: 566525,
        title: "Shang-Chi and the Legend of the Ten Rings",
        backdropPath: "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg",
        popularity: 5098.495,
        rating: 7.9
      ),
      .init(
        posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg",
        overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
        releaseDate: "2021-09-30",
        genreIDs: [878, 28, 12],
        idMovie: 580489,
        title: "Venom: Let There Be Carnage",
        backdropPath: "/efuPybo8V8KTYGslQphO74LRvm0.jpg",
        popularity: 4813.544,
        rating: 6.8
      ),
      .init(
        posterPath: "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg",
        overview: "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.",
        releaseDate: "2021-11-03",
        genreIDs: [28, 12, 878],
        idMovie: 524434,
        title: "Eternals",
        backdropPath: "/fzKWwcaam9QSTaMSJlORuSojxio.jpg",
        popularity: 2460.836,
        rating: 7.2
      )
    ]
    )
  }
}

public extension DetailMovieResponse {
  static var sample: DetailMovieResponse {
    .init(
      tagline: "Not Available",
      status: "Released",
      runtime: 97,
      genres: [
      Genre(id: 0, name: "Science Fiction"),
      Genre(id: 0, name: "Action"),
      Genre(id: 0, name: "Adventure")
      ],
      language: [MovieLanguage(name: "English")]
    )
  }

  static var sampleLocal: DetailMovieResponse {
    .init(
      tagline: "In the beginning...",
      status: "Released",
      runtime: 157,
      genres: [
      Genre(id: 0, name: "Action"),
      Genre(id: 0, name: "Adventure"),
      Genre(id: 0, name: "Science Fiction")
      ],
      language: [MovieLanguage(name: "Arabic")]
    )
  }
}
