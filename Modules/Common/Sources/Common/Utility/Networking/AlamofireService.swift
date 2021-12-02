//
//  AlamofireService.swift
//  
//
//  Created by Dayton on 29/11/21.
//

import Foundation
import RxSwift
import Alamofire

public class AlamofireService: APIService {
  private let session: Session

  public init(session: Session = AF) {
    self.session = session
  }

 public func fetch<ResponseType>(request: URLRequest,
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
