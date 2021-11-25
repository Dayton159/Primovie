//
//  UIView+Extension.swift
//  Primovie
//
//  Created by Dayton on 11/11/21.
//

import UIKit

@IBDesignable
extension UIView {

  func loadNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: self.classForCoder), bundle: bundle)
    guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Can't load Nib") }
    return view
  }

  @IBInspectable var cornerRadius: CGFloat {
    get { return layer.cornerRadius }
    set { layer.cornerRadius = newValue }
  }

  @IBInspectable var borderColor: UIColor? {
    get { return layer.borderColor.map(UIColor.init) }
    set { layer.borderColor = newValue?.cgColor }
  }
  @IBInspectable var borderWidth: CGFloat {
    get { return layer.borderWidth }
    set { layer.borderWidth = newValue }
  }

  func addShadow(opacity: Float = 1.0) {
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowRadius = 3.0
    self.layer.shadowOpacity = opacity
    self.layer.shadowOffset = CGSize(width: 4, height: 4)
    self.layer.masksToBounds = false
  }
}
