//
//  ExploreRouter.swift
//  Primovie
//
//  Created by Dayton on 10/11/21.
//

import UIKit
import Common
import Detail

class ExploreRouter {
  func makeDetailView(movie: MovieModel) -> UIViewController {
    let detailUseCase: DetailMovieInteractor = Injection.init().provideDetail(id: movie.idMovie, model: movie)
    let saveUseCase: SaveMovieInteractor = Injection.init().provideSave()
    let deleteUseCase: DeleteMovieInteractor = Injection.init().provideDelete(id: movie.idMovie)
    let isFavUseCase: IsFavMovieInteractor = Injection.init().provideIsFavorite(id: movie.idMovie)

    let presenter = DetailPresenter(
      detailUseCase: detailUseCase,
      saveUseCase: saveUseCase,
      deleteUseCase: deleteUseCase,
      isFavUseCase: isFavUseCase,
      request: .network)

    return DetailView(presenter: presenter)
  }
}
