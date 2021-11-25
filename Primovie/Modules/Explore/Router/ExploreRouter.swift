//
//  ExploreRouter.swift
//  Primovie
//
//  Created by Dayton on 10/11/21.
//

import UIKit

class ExploreRouter {
  func makeDetailView(movie: MovieModel) -> UIViewController {
    let interactor = Injection.init().provideDetailUseCase(id: movie.idMovie, movie: movie)
    let presenter = DetailPresenter(interactor: interactor, request: .network)
    return DetailView(presenter: presenter)
  }
}
