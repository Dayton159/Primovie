//
//  NowPlayingCollectionViewCell.swift
//  Primovie
//
//  Created by Dayton on 11/11/21.
//

import UIKit
import Common

class NowPlayingCollectionViewCell: UICollectionViewCell, Reusable {
  @IBOutlet weak var movieImage: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var genreStackView: UIStackView!

  override func awakeFromNib() {
      super.awakeFromNib()
  }

  func configureCell(model data: MovieModel) {
    self.movieImage.setImageFrom(path: data.backdropPath)
    self.movieTitle.text = data.title
    self.genreStackView.setGenreValue(with: data.genres.prefix(3).map { $0.makeGenreLabel() })
    self.configureTitle()
  }

  private func configureTitle() {
    self.movieTitle.textColor = .white
    self.movieTitle.addShadow()
  }
}
