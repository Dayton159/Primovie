//
//  HomeView.swift
//  Primovie
//
//  Created by Dayton on 08/11/21.
//

import Home
import Common
import UIKit
import RxSwift

enum Section: String, CaseIterable {
  case nowPlaying = "Now Playing"
  case topRated = "Top Rated"
}

class HomeView: BaseView {
  @IBOutlet weak var collectionView: UICollectionView!
  private let presenter: HomePresenter<HomeInteractor>
  private lazy var dataSource = makeDataSource()
  private var sections = Section.allCases

  // MARK: - Value Types
  typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieModel>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MovieModel>

  init(presenter: HomePresenter<HomeInteractor>) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.configureLayout()
    self.bindPresenter()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.configureNavBar(withTitle: "Primovie", prefersLargeTitles: true)
  }

  private func makeDataSource() -> DataSource {
    let dataSource = DataSource(
      collectionView: collectionView) { collectionView, indexPath, _ in
        switch self.sections[indexPath.section] {
        case .nowPlaying:
          let cell: NowPlayingCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
          let model = self.presenter.getNowPlaying(at: indexPath)
          cell.configureCell(model: model)
          return cell
        case .topRated:
          let cell: TopRatedCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
          let model = self.presenter.getTopRated(at: indexPath)
          cell.configureCell(model: model)
          return cell
        }
      }
    dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
      guard kind == UICollectionView.elementKindSectionHeader else {
        return nil
      }
      let section = self.dataSource.snapshot()
        .sectionIdentifiers[indexPath.section]
      let view: CollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: .header, forIndexPath: indexPath)
      view.setHeader(with: section.rawValue)
      return view
    }
    return dataSource
  }

  private func configureLayout() {
    self.collectionView.registerReusableCell(NowPlayingCollectionViewCell.self)
    self.collectionView.registerReusableCell(TopRatedCollectionViewCell.self)
    self.collectionView.register(view: CollectionHeaderView.self, asSupplementaryViewKind: .header)
    self.collectionView.delegate = self

    collectionView.collectionViewLayout = UICollectionViewCompositionalLayout {(index: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      switch self.sections[index] {
      case .nowPlaying: return LayoutBuilder.buildNowPlayingSectionLayout()
      case .topRated: return LayoutBuilder.buildTopRatedSectionLayout()
      }
    }
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

    Observable.combineLatest(self.presenter.nowPlayingObs, self.presenter.topRatedObs)
      .observe(on: MainScheduler.instance)
      .filter { !$0.isEmpty && !$1.isEmpty}
      .subscribe(onNext: { [weak self] nowPlaying, topRated in
        guard let self = self else { return }
        self.applySnapshot(now: nowPlaying, top: topRated)
      }).disposed(by: disposeBag)

    self.presenter.getMovies(.nowPlaying)
    self.presenter.getMovies(.topRated)
  }

  private func applySnapshot(now: [MovieModel], top: [MovieModel], animatingDifferences: Bool = true) {
    var snapshot = Snapshot()
    snapshot.appendSections([.nowPlaying, .topRated])
    snapshot.appendItems(now, toSection: .nowPlaying)
    snapshot.appendItems(top, toSection: .topRated)
    dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeView: AlertPopUpPresentable, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let movie = dataSource.itemIdentifier(for: indexPath) else { return }
    let detail = HomeRouter().makeDetailView(movie: movie)
    self.show(detail, sender: self)
  }
}
