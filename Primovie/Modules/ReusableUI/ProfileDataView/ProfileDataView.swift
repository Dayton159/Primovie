//
//  ProfileDataView.swift
//  Primovie
//
//  Created by Dayton on 14/11/21.
//

import UIKit

@IBDesignable
class ProfileDataView: UIView {
  // MARK: - Properties
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var profileLabel: UILabel!

  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }
}

// MARK: - Extensions
extension ProfileDataView {
  func xibSetup() {
    contentView = loadNib()
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(contentView)
  }
}

extension ProfileDataView {
  @IBInspectable var image: UIImage? {
    get { return imageView.image }
    set { self.imageView.image = newValue }
  }

  @IBInspectable var profileData: String? {
    get { return profileLabel.text }
    set { self.profileLabel.text = newValue }
  }
}
