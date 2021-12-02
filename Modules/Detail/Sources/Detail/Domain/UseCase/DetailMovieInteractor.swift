//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import Common

public typealias DetailMovieRepository = MovieRepository<DetailRemoteDataSource, DetailLocalDataSource, RemoteMapper, LocalMapper>
public typealias DetailMovieInteractor = Interactor<DataRequestSource, DetailModel, DetailMovieRepository>
