//
//  DetailView.swift
//  Primovie
//
//  Created by Dayton on 11/11/21.
//

import Detail
import UIKit
import RxSwift

class DetailView: BaseView {
  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  private let presenter: DetailPresenter<
    DetailMovieInteractor,
    SaveMovieInteractor,
    DeleteMovieInteractor,
    IsFavMovieInteractor>

  init(presenter: DetailPresenter<
       DetailMovieInteractor,
       SaveMovieInteractor,
       DeleteMovieInteractor,
       IsFavMovieInteractor>) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.configureRightBarButtonItem(with: Constants.Image.bookmark, type: .toogle)
    self.configureTableView()
    self.bindPresenter()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.configureNavBar(withTitle: "Detail")
  }

  private func configureTableView() {
    self.tableView.registerReusableCell(PropertyPosterTableViewCell.self)
    self.tableView.registerReusableCell(TitleGenreTableViewCell.self)
    self.tableView.registerReusableCell(ContentTableViewCell.self)
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
          Delay.execute { self.showLoader() }
        default:
          Delay.execute { self.hideLoader() }
        }
      }).disposed(by: disposeBag)

    self.presenter.error
      .asObservable()
      .subscribe(onNext: { [weak self] error in
        guard let self = self else { return }
        Delay.wait(delay: 0.5) {
          self.showError(error, delegate: self)
        }
      }).disposed(by: disposeBag)

    self.presenter.detailMovieObs
      .observe(on: MainScheduler.instance)
      .compactMap { $0 }
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.enableBarBtn()
        self.presenter.isMovieFavorited()
        self.tableView.reloadData()
      }).disposed(by: disposeBag)

    self.presenter.isFavoriteObs
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] favorite in
        guard let self = self else { return }
        self.changeFavBtnState(isFav: favorite)
      }).disposed(by: disposeBag)

    self.favBarBtnObs
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] favValue in
        guard let self = self else { return }
        favValue ? self.presenter.saveMovieToFavorite() : self.presenter.deleteFavoriteMovie()
      }).disposed(by: disposeBag)

    self.presenter.getMovieDetail()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension DetailView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell: PropertyPosterTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      let detail = self.presenter.detailItem
      cell.configureCell(detail: detail)
      return cell
    case 1:
      let cell: TitleGenreTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      let detail = self.presenter.detailItem
      cell.configureCell(detail: detail)
      return cell
    default:
      let cell: ContentTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      let detail = self.presenter.detailItem
      cell.configureCell(detail: detail)
      return cell
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case 0:
      return 350
    case 1:
      return 125
    default:
      return UITableView.automaticDimension
    }
  }
}

extension DetailView: AlertPopUpPresentable, AlertDelegate {
  func didTapOkButton() {
    self.navigationController?.popViewController(animated: true)
  }
}
