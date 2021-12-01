//
//  File.swift
//  
//
//  Created by Dayton on 01/12/21.
//

import Primovie_Core
import Common

public typealias ExploreRepository = MovieListRepository<ExploreDataSource, ExploreMapper>
public typealias ExploreInteractor = Interactor<String, [MovieModel], ExploreRepository>
