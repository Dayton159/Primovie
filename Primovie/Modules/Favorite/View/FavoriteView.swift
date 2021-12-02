//
//  FavoriteView.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

import Favorite
import UIKit
import RxSwift

class FavoriteView: BaseView {
  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  private let presenter: FavoritesPresenter

  init(presenter: FavoritesPresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.configureRightBarButtonItem(with: Constants.Image.profile)
    self.configureTableView()
    self.bindPresenter()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.configureNavBar(withTitle: "Favorite", prefersLargeTitles: true)
    self.presenter.getList(request: nil)
  }

  private func configureTableView() {
    self.tableView.registerReusableCell(MovieListTableViewCell.self)
    self.tableView.tableFooterView = UIView()
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = UITableView.automaticDimension
    self.tableView.backgroundColor = .white
    self.tableView.separatorStyle = .none
    self.tableView.keyboardDismissMode = .onDrag
    self.tableView.contentInsetAdjustmentBehavior = .never
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }

  private func bindPresenter() {
    self.presenter.state
      .asObservable()
      .subscribe(onNext: { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .loading:
          Delay.execute {
            self.showLoader()
          }
        default:
          Delay.execute {
            self.hideLoader()
          }
        }
      }).disposed(by: disposeBag)

    self.presenter.error
      .asObservable()
      .subscribe(onNext: { [weak self] error in
        guard let self = self else { return }
        Delay.wait(delay: 0.5) {
          self.showError(error)
        }
      }).disposed(by: disposeBag)

    self.presenter.listObs
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.tableView.reloadData()
      }).disposed(by: disposeBag)

    self.defaultBarBtnObs
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else { return }
        let about = FavoriteRouter().makeAboutView()
        self.show(about, sender: self)
      }).disposed(by: disposeBag)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension FavoriteView: AlertPopUpPresentable, EmptyViewDelegate {
  func didTapButtonAction() {
    self.presenter.getList(request: nil)
  }
}

extension FavoriteView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.presenter.getNumberOfItems == 0 {
      tableView.setEmptyView(
        title: "Movie Data Empty",
        detail: "Oops! Seems like there is nothing to be found.",
        titleBtn: "Refresh",
        delegate: self
      )
    } else {
      tableView.restore()
    }
    return self.presenter.getNumberOfItems
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: MovieListTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
    let data = self.presenter.getItemAt(indexPath)
    cell.configureCell(data: data)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let model = self.presenter.getItemAt(indexPath)
    let detail = FavoriteRouter().makeDetailView(movie: model)
    self.show(detail, sender: self)
  }
}
