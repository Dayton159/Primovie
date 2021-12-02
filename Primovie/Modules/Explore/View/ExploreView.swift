//
//  ViewController.swift
//  Primovie
//
//  Created by Dayton on 06/11/21.
//

import Explore
import UIKit
import SkeletonView
import RxSwift

class ExploreView: BaseView {
  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  private let presenter: ExplorePresenter
  private let searchController = UISearchController(searchResultsController: nil)

  init(presenter: ExplorePresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.configureSearchBar()
    self.configureTableView()
    self.bindPresenter()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.configureNavBar(withTitle: "Explore")
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

  private func configureSearchBar() {
    searchController.searchBar.showsCancelButton = true
    navigationItem.searchController = searchController
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = "Search Movie"
  }

  private func bindPresenter() {
    self.presenter.state
      .asObservable()
      .subscribe(onNext: { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .loading:
          Delay.execute {
            self.view.showAnimatedSkeleton(usingColor: .gray)
            self.showLoader()
          }
        default:
          Delay.execute {
            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
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

    searchController.searchBar.rx.text.orEmpty
      .asObservable()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] value in
        guard let self = self else { return }
        self.presenter.getList(request: value)
      }).disposed(by: disposeBag)

    self.presenter.getList(request: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ExploreView: AlertPopUpPresentable, EmptyViewDelegate {
  func didTapButtonAction() {
    self.presenter.getList(request: nil)
  }
}

extension ExploreView: UITableViewDelegate, UITableViewDataSource {

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
    let detail = ExploreRouter().makeDetailView(movie: model)
    self.show(detail, sender: self)
  }
}

extension ExploreView: SkeletonTableViewDataSource {

  func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }

  func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return MovieListTableViewCell.reuseIdentifier
  }
}
