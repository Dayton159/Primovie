//
//  BasePresenter.swift
//  Primovie
//
//  Created by Dayton on 10/11/21.
//

import RxSwift

enum NetworkState {
  case loading
  case finish
  case error
}

class BasePresenter {
  let disposeBag  = DisposeBag()
  var state       = PublishSubject<NetworkState>()
  var error       = PublishSubject<String>()
}
