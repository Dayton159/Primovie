//
//  EmptyViewBuilder.swift
//  Primovie
//
//  Created by Dayton on 11/11/21.
//

class EmptyViewBuilder {
  private var emptyView = EmptyView()

  @discardableResult
  func setEmpty(_ title: String?, _ msg: String?) -> EmptyViewBuilder {
    emptyView.titleLabel.text = title
    emptyView.msgLabel.text = msg
    return self
  }

  @discardableResult
  func setButtonTitle(_ buttonTitle: String?, delegate: EmptyViewDelegate?) -> EmptyViewBuilder {
    emptyView.reloadButton.isHidden = false

    emptyView.reloadButton.setTitle(buttonTitle, for: .normal)
    emptyView.delegate = delegate
    return self
  }

  func build() -> EmptyView {
    return emptyView
  }
}
