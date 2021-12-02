//
//  File.swift
//  
//
//  Created by Dayton on 30/11/21.
//

public extension MovieModel {
  static var samples: [MovieModel] {
    .init(
    [
      .init(
        idMovie: 566525,
        title: "Shang-Chi and the Legend of the Ten Rings",
        overview: "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.",
        releaseDate: "01 Sep 2021",
        genres: [],
        popularity: "5098.5",
        rating: "7.9",
        backdropPath: "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg",
        posterPath: "/xeItgLK9qcafxbd8kYgv7XnMEog.jpg"
      ),
      sample,
      sampleLocal
    ]
    )
  }

  static var sample: MovieModel {
    .init(
      idMovie: 580489,
      title: "Venom: Let There Be Carnage",
      overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
      releaseDate: "30 Sep 2021",
      genres: [],
      popularity: "4813.5",
      rating: "6.8",
      backdropPath: "/efuPybo8V8KTYGslQphO74LRvm0.jpg",
      posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg"
    )
  }

    static var sampleLocal: MovieModel {
      .init(
        idMovie: 524434,
        title: "Eternals",
        overview: "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.",
        releaseDate: "03 Nov 2021",
        genres: [],
        popularity: "2460.8",
        rating: "7.2",
        backdropPath: "/fzKWwcaam9QSTaMSJlORuSojxio.jpg",
        posterPath: "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg"
      )
  }
}

public extension DetailModel {
  static var sample: DetailModel {
    .init(
      idMovie: 580489,
      title: "Venom: Let There Be Carnage",
      overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
      releaseDate: "30 Sep 2021",
      genres: ["Science Fiction", "Action", "Adventure"],
      popularity: "4813.5",
      rating: "6.8",
      backdropPath: "/efuPybo8V8KTYGslQphO74LRvm0.jpg",
      posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg",
      tagline: "Not Available",
      status: "Released",
      runtime: "1h 37m",
      language: "English"
    )
  }

  static var sampleLocal: DetailModel {
    .init(
      idMovie: 524434,
      title: "Eternals",
      overview: "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.",
      releaseDate: "03 Nov 2021",
      genres: ["Action", "Adventure", "Science Fiction"],
      popularity: "2460.8",
      rating: "7.2",
      backdropPath: "/fzKWwcaam9QSTaMSJlORuSojxio.jpg",
      posterPath: "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg",
      tagline: "In the beginning...",
      status: "Released",
      runtime: "2h 37m",
      language: "Arabic"
    )
  }
}
