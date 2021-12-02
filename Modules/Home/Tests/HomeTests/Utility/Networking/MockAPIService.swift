//
//  File.swift
//  
//
//  Created by Dayton on 30/11/21.
//
import Foundation
import Common
import RxSwift

public class MockAPIService: APIService {
  public var dummyResponse: String = ""
  public var expPathname: String?
  public var expMethod: String?
  public var expError: Error?
  public var expQueryItemParam: String?
  public var expQueryItemString: String?

  public func fetch<ResponseType>(request: URLRequest, decodeTo: ResponseType.Type) -> Single<ResponseType> where ResponseType: Decodable {
    return Single<ResponseType>.create { single in

      if let error = self.expError {
        single(.failure(error))
      }

      if let pathname = self.expPathname, request.url?.path != pathname {
        single(.failure(NSError(domain: "PrimovieTest", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Pathname invalid. Expected: \(pathname). Actual: \(request.url?.path ?? "nil")"])))
      }

      if let method = self.expMethod, request.method?.rawValue != method {
        single(.failure(NSError(domain: "PrimovieTest", code: 1002, userInfo: [NSLocalizedDescriptionKey: "Method invalid. Expected: \(method). Actual: \(request.method?.rawValue ?? "nil")"])))
      }

      if let param = self.expQueryItemParam, let actualValue = self.getQueryStringParameter(url: request.url?.absoluteString, param: param) {
        if self.expQueryItemString != actualValue {
          single(.failure(NSError(domain: "PrimovieTest", code: 400, userInfo: [NSLocalizedDescriptionKey: "Param invalid. Expected: Param \(param) with value \(self.expQueryItemString ?? "nil"). Actual: \(actualValue)"])))
        }
      }
      do {
        let value = try self.dummyDecoded(to: ResponseType.self)
        single(.success(value))
      } catch {
        single(.failure(error))
      }
      return Disposables.create()
    }
  }

  private func getQueryStringParameter(url: String?, param: String) -> String? {
    guard let stringURL = url,
          let url = URLComponents(string: stringURL) else { return nil }
    return url.queryItems?.first(where: { $0.name == param })?.value
  }

  private func dummyDecoded<T> (to: T.Type) throws -> T where T: Decodable {
    let data = dummyResponse.data(using: .utf8)
    let decoded = try JSONDecoder().decode(to, from: data!)
    return decoded
  }
}
