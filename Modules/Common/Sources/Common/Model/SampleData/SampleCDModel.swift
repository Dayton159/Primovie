//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import CoreData

public extension CDMovieFavorite {
  static func createListSample(context: NSManagedObjectContext) -> [CDMovieFavorite] {
    let favorite1 = CDMovieFavorite(context: context)
    favorite1.idMovie = 566525
    favorite1.title = "Shang-Chi and the Legend of the Ten Rings"
    favorite1.overview = "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization."
    favorite1.releaseDate = DateFormatter.JSONResponse.dateFromString("2021-09-01")
    favorite1.genres = []
    favorite1.popularity = 5098.5
    favorite1.rating = 7.9
    favorite1.backdropPath = "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg"
    favorite1.posterPath = "/xeItgLK9qcafxbd8kYgv7XnMEog.jpg"

    let favorite2 = CDMovieFavorite(context: context)
    favorite2.idMovie = 580489
    favorite2.title = "Venom: Let There Be Carnage"
    favorite2.overview = "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady."
    favorite2.releaseDate = DateFormatter.JSONResponse.dateFromString("2021-09-30")
    favorite2.genres = []
    favorite2.popularity = 4813.5
    favorite2.rating = 6.8
    favorite2.backdropPath = "/efuPybo8V8KTYGslQphO74LRvm0.jpg"
    favorite2.posterPath = "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg"

    let favorite3 = CDMovieFavorite(context: context)
    favorite3.idMovie = 524434
    favorite3.title = "Eternals"
    favorite3.overview = "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants."
    favorite3.releaseDate = DateFormatter.JSONResponse.dateFromString("2021-11-03")
    favorite3.genres = []
    favorite3.popularity = 2460.8
    favorite3.rating = 7.2
    favorite3.backdropPath = "/fzKWwcaam9QSTaMSJlORuSojxio.jpg"
    favorite3.posterPath = "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg"

    return [favorite1, favorite2, favorite3]
  }

  static func createDetailSample(context: NSManagedObjectContext) -> CDMovieFavorite {
    let detail = CDMovieFavorite(context: context)
    detail.idMovie = 524434
    detail.title = "Eternals"
    detail.overview = "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants."
    detail.releaseDate = DateFormatter.JSONResponse.dateFromString("2021-11-03")
    detail.genres = ["Action", "Adventure", "Science Fiction"]
    detail.popularity = 2460.8
    detail.rating = 7.2
    detail.backdropPath = "/fzKWwcaam9QSTaMSJlORuSojxio.jpg"
    detail.posterPath = "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg"
    detail.tagline = "In the beginning..."
    detail.status = "Released"
    detail.runtime = 157
    detail.language = "Arabic"

    return detail
  }
}
