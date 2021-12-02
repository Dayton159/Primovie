//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

import Primovie_Core
import Common

public typealias SaveMovieRepository = SaveRepository<SaveDataSource, SaveMapper>
public typealias SaveMovieInteractor = Interactor<DetailModel, Void, SaveMovieRepository>
