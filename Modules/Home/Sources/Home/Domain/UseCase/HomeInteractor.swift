//
//  HomeInteractor.swift
//  
//
//  Created by Dayton on 30/11/21.
//

import Primovie_Core
import Common

public typealias HomeRepository = MovieListRepository<MovieListDataSource, HomeMapper>
public typealias HomeInteractor = Interactor<MovieRequest, [MovieModel], HomeRepository>
