//
//  CollectionHeaderView.swift
//  Primovie
//
//  Created by Dayton on 12/11/21.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView, Reusable {
  @IBOutlet weak var headerLabel: UILabel!

  override func awakeFromNib() {
      super.awakeFromNib()
  }

  func setHeader(with value: String) {
    self.headerLabel.text = value
  }
}
