//
//  TitleGenreTableViewCell.swift
//  Primovie
//
//  Created by Dayton on 13/11/21.
//

import UIKit

class TitleGenreTableViewCell: UITableViewCell, Reusable {
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var genreStackView: UIStackView!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func configureCell(detail model: DetailModel) {
    self.movieTitle.text = model.title
    self.genreStackView.setGenreValue(with: model.genres.prefix(3).map { $0.makeGenreLabel() })
  }
}
