//
//  API.swift
//  
//
//  Created by Dayton on 29/11/21.
//

import Foundation
import RxSwift

public protocol APIService {
  func fetch<ResponseType: Decodable>(request: URLRequest,
                                      decodeTo: ResponseType.Type) -> Single<ResponseType>
}

public class API<Request: APIRequest> {
  private let apiService: APIService

  public init(apiService: APIService = AlamofireService()) {
    self.apiService = apiService
  }

  public func fetch(_ request: Request) -> Single<Request.Response> {
    let urlRequest = request.makeURLRequest()
    return self.apiService.fetch(request: urlRequest, decodeTo: Request.Response.self)
  }
}
