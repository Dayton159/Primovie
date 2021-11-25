//
//  RatingView.swift
//  Primovie
//
//  Created by Dayton on 11/11/21.
//

import UIKit

@IBDesignable
class RatingView: UIView {
  // MARK: - Properties
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var ratingValue: UILabel!

  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }

  func setRatingValue(_ value: String) {
    self.ratingValue.text = value
  }
}

// MARK: - Extensions
extension RatingView {
func xibSetup() {
  contentView = loadNib()
  contentView.frame = bounds
  contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  addSubview(contentView)
}
}
