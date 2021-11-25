//
//  MovieListTableViewCell.swift
//  Primovie
//
//  Created by Dayton on 11/11/21.
//

import UIKit

class MovieListTableViewCell: UITableViewCell, Reusable {
  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var ratingView: RatingView!
  @IBOutlet weak var movieOverview: UILabel!
  @IBOutlet weak var releasedDateValue: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func configureCell(data: MovieModel) {
    self.movieImageView.setImageFrom(path: data.backdropPath)
    self.movieTitle.text = data.title
    self.ratingView.setRatingValue(data.rating)
    self.movieOverview.text = data.overview
    self.releasedDateValue.text = data.releaseDate
  }
}
