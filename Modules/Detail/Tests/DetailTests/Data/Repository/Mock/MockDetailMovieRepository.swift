//
//  File.swift
//  
//
//  Created by Dayton on 02/12/21.
//

@testable import Detail

public typealias MockDetailMovieRepository = MovieRepository<MockRemoteDataSource, MockLocalDataSource, RemoteMapper, LocalMapper>
