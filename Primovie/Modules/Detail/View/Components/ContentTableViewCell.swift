//
//  ContentTableViewCell.swift
//  Primovie
//
//  Created by Dayton on 13/11/21.
//

import UIKit

class ContentTableViewCell: UITableViewCell, Reusable {
  @IBOutlet weak var taglineValue: UILabel!
  @IBOutlet weak var overviewValue: UILabel!
  @IBOutlet weak var statusValue: UILabel!
  @IBOutlet weak var popularityValue: UILabel!
  @IBOutlet weak var languageValue: UILabel!

  func configureCell(detail model: DetailModel) {
    self.taglineValue.text = model.tagline
    self.overviewValue.text = model.overview
    self.statusValue.text = model.status
    self.popularityValue.text = model.popularity
    self.languageValue.text = model.language
  }
}
