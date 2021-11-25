//
//  LayoutBuilder.swift
//  Primovie
//
//  Created by Dayton on 11/11/21.
//

import UIKit

class LayoutBuilder {
  static func buildNowPlayingSectionLayout() -> NSCollectionLayoutSection {
    // Item
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(0.72))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    // Group
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.95),
      heightDimension: .fractionalWidth(2/3))

    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitem: item,
      count: 1)
    group.contentInsets = NSDirectionalEdgeInsets(
      top: 0,
      leading: 5,
      bottom: 0,
      trailing: 5)

    // Header
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(50))
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top)

    // Section
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [sectionHeader]
    section.orthogonalScrollingBehavior = .groupPaging

    return section
  }

  static func buildTopRatedSectionLayout() -> NSCollectionLayoutSection {
    // Item
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

    // Group
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(0.6))

    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

    // Header
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(50))
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top)

    // Section
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [sectionHeader]

    return section
  }
}
