//
//  PropertyPosterTableViewCell.swift
//  Primovie
//
//  Created by Dayton on 13/11/21.
//

import UIKit
import Common

class PropertyPosterTableViewCell: UITableViewCell, Reusable {
  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var datePropertyView: MoviePropertiesView!
  @IBOutlet weak var durationPropertyView: MoviePropertiesView!
  @IBOutlet weak var ratingPropertyView: MoviePropertiesView!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func configureCell(detail model: DetailModel) {
    self.movieImageView.setImageFrom(path: model.posterPath)
    self.datePropertyView.setValue(value: model.releaseDate)
    self.durationPropertyView.setValue(value: model.runtime)
    self.ratingPropertyView.setValue(value: "\(model.rating) / 10")
  }
}
