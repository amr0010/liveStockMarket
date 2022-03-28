//
//  NewsFeedViewController+Layout.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 28/03/2022.
//

import UIKit

extension NewsFeedViewController {
     func configureLayout()  {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) in
            guard let self = self else { return self?.generateStockTickersLayout()}
            switch sectionIndex {
            case 0:
                return self.generateStockTickersLayout()
            case 1:
                return self.generateNewsFeedHorizentalLayout()
            case 2:
                return self.generateNewsFeedVerticalLayout()
            default:
                assertionFailure("section not handled")
                return self.generateStockTickersLayout()
            }
        })
    }



    private func generateStockTickersLayout() -> NSCollectionLayoutSection {
        // 1- Identify Item and itemSize
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // 2- Identify Group and groupSize
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1/3),
            heightDimension: .estimated(20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
      }

    private func generateNewsFeedHorizentalLayout() -> NSCollectionLayoutSection {
        // 1- Identify Item and itemSize
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // 2- Identify Group and groupSize
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
       
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
      }

    private func generateNewsFeedVerticalLayout() -> NSCollectionLayoutSection {
        // 1- Identify Item and itemSize
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(500))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // 2- Identify Group and groupSize
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(500))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        // 3- return section
        let section = NSCollectionLayoutSection(group: group)
        return section
      }

}
