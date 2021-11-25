//
//  BaseModel.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

import RxSwift
import JGProgressHUD

enum BarButtonType {
  case toogle
  case defaultAction
}

open class BaseView: UIViewController {
  static let lightHud = JGProgressHUD(style: .light)
  public var disposeBag = DisposeBag()

  private var defaultBarBtn = PublishSubject<Void>()
  private var favBarBtn = PublishSubject<Bool>()
  private var isFavorited: Bool?
  private var barBtnType: BarButtonType?

  public var defaultBarBtnObs: Observable<Void> {
    return defaultBarBtn.asObservable()
  }

  public var favBarBtnObs: Observable<Bool> {
    return favBarBtn.asObservable()
  }

  private lazy var rightBtnItem: UIButton = {
    let button = UIButton()
    button.tintColor = .black
    button.addTarget(self, action: #selector(self.didTapRightBarBtn(_:)), for: .touchUpInside)
    return button
  }()

  @objc func didTapRightBarBtn(_ sender: UIButton) {
    guard let type = barBtnType else { return }
    switch type {
    case .defaultAction:
      defaultBarBtn.onNext(())
    case .toogle:
      guard let favState = self.isFavorited else { return }
      favBarBtn.onNext(!favState)
    }
  }

  func showLoader(withText text: String? = "Loading") {
    BaseView.lightHud.textLabel.text = text
    BaseView.lightHud.show(in: view)
  }

  func hideLoader() {
    BaseView.lightHud.dismiss()
  }

  func configureNavBar(withTitle title: String? = nil, prefersLargeTitles: Bool = false) {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: Constants.Font.bold(36)]
    appearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: Constants.Font.bold(18)]
    appearance.backgroundColor = .white

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance

    navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
    navigationItem.title = title

    navigationController?.navigationBar.tintColor = .black
    navigationController?.navigationBar.isTranslucent = true

    navigationController?.navigationBar.overrideUserInterfaceStyle = .light
    self.navigationController?.navigationBar.barStyle = .default
  }
}

extension BaseView {
  func configureRightBarButtonItem(with image: UIImage?, type: BarButtonType = .defaultAction) {
    let barItem = UIBarButtonItem(customView: rightBtnItem)
    self.setBarBtnImage(image)
    self.enableBarBtn(enable: type == .defaultAction ? true : false)
    self.barBtnType = type
    navigationItem.rightBarButtonItems = [barItem]
  }

  func enableBarBtn(enable: Bool = true) {
    self.rightBtnItem.isUserInteractionEnabled = enable
    self.rightBtnItem.isEnabled = enable
  }

  private func setBarBtnImage(_ image: UIImage?) {
    self.rightBtnItem.setImage(image, for: .normal)
  }

  func changeFavBtnState(isFav: Bool) {
    self.isFavorited = isFav
    self.setBarBtnImage(isFav ? Constants.Image.bookmarkFill : Constants.Image.bookmark)
  }
}
