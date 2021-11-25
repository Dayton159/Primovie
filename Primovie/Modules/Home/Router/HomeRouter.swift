//
//  HomeRouter.swift
//  Primovie
//
//  Created by Dayton on 11/11/21.
//

import UIKit

class HomeRouter {
  func makeDetailView(movie: MovieModel) -> UIViewController {
    let interactor = Injection.init().provideDetailUseCase(id: movie.idMovie, movie: movie)
    let presenter = DetailPresenter(interactor: interactor, request: .network)
    return DetailView(presenter: presenter)
  }
}
