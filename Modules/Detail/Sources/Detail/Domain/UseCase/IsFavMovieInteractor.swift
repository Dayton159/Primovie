//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core

public typealias IsFavoriteMovieRepository = IsFavoriteRepository<IsFavoritedDataSource>
public typealias IsFavMovieInteractor = Interactor<Any, Bool, IsFavoriteMovieRepository>
