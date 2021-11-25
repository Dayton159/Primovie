//
//  MoviePropertiesView.swift
//  Primovie
//
//  Created by Dayton on 13/11/21.
//

import UIKit

@IBDesignable
class MoviePropertiesView: UIView {
  // MARK: - Properties
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var propertyValue: UILabel!

  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }

  func setValue(value: String) {
    self.propertyValue.text = value
  }
}

// MARK: - Extensions
extension MoviePropertiesView {
  func xibSetup() {
    contentView = loadNib()
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    contentView.addShadow(opacity: 0.5)
    addSubview(contentView)
  }
}

extension MoviePropertiesView {
  @IBInspectable var image: UIImage? {
    get { return imageView.image }
    set { self.imageView.image = newValue }
  }

  @IBInspectable var title: String? {
    get { return titleLabel.text }
    set { self.titleLabel.text = newValue }
  }
}
