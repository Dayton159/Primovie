//
//  AlamofireService.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

import Foundation
import RxSwift
import Alamofire

class AlamofireService: APIService {
  let session: Session

  init(session: Session = AF) {
    self.session = session
  }

  func fetch<ResponseType>(request: URLRequest,
                           decodeTo: ResponseType.Type) -> Single<ResponseType> where ResponseType: Decodable {
    return Single<ResponseType>.create { single in
      let afRequest = self.session.request(request).validate()
      afRequest.responseDecodable(of: ResponseType.self) { response in
        switch response.result {
        case .success(let decodedResponse):
          single(.success(decodedResponse))
        case .failure(let error):
          single(.failure(error))
        }
      }
      return Disposables.create()
    }
  }
}
