//
//  TopRatedCollectionViewCell.swift
//  Primovie
//
//  Created by Dayton on 11/11/21.
//

import UIKit

class TopRatedCollectionViewCell: UICollectionViewCell, Reusable {
  @IBOutlet weak var movieImage: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var ratingView: RatingView!

  override func awakeFromNib() {
      super.awakeFromNib()
  }

  func configureCell(model data: MovieModel) {
    self.movieImage.setImageFrom(path: data.backdropPath)
    self.movieTitle.text = data.title
    self.ratingView.setRatingValue(data.rating)
  }
}
