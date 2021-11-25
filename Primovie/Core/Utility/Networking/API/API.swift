//
//  APIService.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

import Foundation
import RxSwift

protocol APIService {
  func fetch<ResponseType: Decodable>(request: URLRequest,
                                      decodeTo: ResponseType.Type) -> Single<ResponseType>
}

class API<Request: APIRequest> {
  private let apiService: APIService

  init(apiService: APIService = AlamofireService()) {
    self.apiService = apiService
  }

  func fetch(_ request: Request) -> Single<Request.Response> {
    let urlRequest = request.makeURLRequest()
    return self.apiService.fetch(request: urlRequest, decodeTo: Request.Response.self)
  }
}
