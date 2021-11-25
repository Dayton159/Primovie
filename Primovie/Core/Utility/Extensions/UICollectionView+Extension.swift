//
//  UICollectionView+Extension.swift
//  Primovie
//
//  Created by Dayton on 12/11/21.
//

import UIKit

extension UICollectionView {

  func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
    if let nib = T.nib {
      self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    } else {
      self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
  }

  func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: Reusable {
    guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
    else { fatalError("Can't Dequeue cell \(T.self)") }

    return cell
  }

  func register<T: UICollectionReusableView>(view: T.Type, asSupplementaryViewKind kind: SupplementaryViewKind) where T: Reusable {
    register(T.nib, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.reuseIdentifier)
  }

  func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: SupplementaryViewKind, forIndexPath indexPath: IndexPath) -> T where T: Reusable {
      guard let view = dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
          fatalError("Could not dequeue view with identifier: \(T.reuseIdentifier)")
      }
      return view
  }
}

extension UICollectionView {
  enum SupplementaryViewKind {
      case header
      case footer

      var rawValue: String {
          switch self {
          case .header:
              return UICollectionView.elementKindSectionHeader
          case .footer:
              return UICollectionView.elementKindSectionFooter
          }
      }
  }
}
