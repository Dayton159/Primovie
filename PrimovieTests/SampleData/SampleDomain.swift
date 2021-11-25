//
//  SampleDomain.swift
//  PrimovieTests
//
//  Created by Dayton on 15/11/21.
//

@testable import Primovie

struct SampleDomain {
  static let listMovieModel = [
  MovieModel(
    idMovie: 566525,
    title: "Shang-Chi and the Legend of the Ten Rings",
    overview: "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.",
    releaseDate: "1 Sep 2021",
    genres: ["Action", "Adventure", "Fantasy"],
    popularity: "5098.4",
    rating: "7.9",
    backdropPath: "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg",
    posterPath: "/xeItgLK9qcafxbd8kYgv7XnMEog.jpg"
  ),
  MovieModel(
    idMovie: 580489,
    title: "Venom: Let There Be Carnage",
    overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
    releaseDate: "30 Sep 2021",
    genres: ["Science Fiction", "Action", "Adventure"],
    popularity: "4813.5",
    rating: "6.8",
    backdropPath: "/efuPybo8V8KTYGslQphO74LRvm0.jpg",
    posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg"
  ),
  MovieModel(
    idMovie: 524434,
    title: "Eternals",
    overview: "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.",
    releaseDate: "3 Nov 2021",
    genres: ["Action", "Adventure", "Science Fiction"],
    popularity: "2460.8",
    rating: "7.2",
    backdropPath: "/fzKWwcaam9QSTaMSJlORuSojxio.jpg",
    posterPath: "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg"
  )
  ]

  static let detailModel = DetailModel(
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
    language: "English")

  static let detailModelLocal = DetailModel(
    idMovie: 524434,
    title: "Eternals",
    overview: "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
    releaseDate: "3 Nov 2021",
    genres: ["Action", "Adventure", "Science Fiction"],
    popularity: "2460.8",
    rating: "7.2",
    backdropPath: "/fzKWwcaam9QSTaMSJlORuSojxio.jpg",
    posterPath: "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg",
    tagline: "In the beginning...",
    status: "Released",
    runtime: "2h 37m",
    language: "Arabic")
}
