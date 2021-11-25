//
//  AlertPresentable.swift
//  Primovie
//
//  Created by Dayton on 11/11/21.
//

import UIKit

protocol AlertDelegate: AnyObject {
  func didTapOkButton()
}

protocol AlertPopUpPresentable where Self: UIViewController { }

extension AlertPopUpPresentable {
  func showError(_ errorMessage: String, delegate: AlertDelegate? = nil) {
    let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)

    let action = UIAlertAction(title: "OK", style: .cancel) { _ in
      delegate?.didTapOkButton()
    }

    alert.addAction(action)
    showDetailViewController(alert, sender: self)
  }
}
