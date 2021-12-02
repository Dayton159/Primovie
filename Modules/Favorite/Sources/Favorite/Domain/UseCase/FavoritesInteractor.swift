//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Primovie_Core
import Common

public typealias FavoritesRepository = MovieListLocalRepository<FavoritesDataSource, FavoritesMapper>
public typealias FavoritesInteractor = Interactor<Any, [MovieModel], FavoritesRepository>
