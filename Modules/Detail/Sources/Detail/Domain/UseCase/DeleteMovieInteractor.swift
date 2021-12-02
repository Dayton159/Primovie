//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core

public typealias DeleteMovieRepository = DeleteRepository<DeleteDataSource>
public typealias DeleteMovieInteractor = Interactor<Any, Void, DeleteMovieRepository>
