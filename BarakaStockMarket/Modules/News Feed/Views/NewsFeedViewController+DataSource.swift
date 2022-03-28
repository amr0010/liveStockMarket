//
//  NewsFeedViewController+DataSource.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 28/03/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Differentiator
extension NewsFeedViewController {
    
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<HomeFeedSection> {
        return RxCollectionViewSectionedReloadDataSource<HomeFeedSection>(
            configureCell: { dataSource, collectionView, indexPath, element in
                switch dataSource[indexPath] {
                case let .StockTickerItem(model):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockTickerCell.identifier, for: indexPath) as? StockTickerCell else { return UICollectionViewCell() }
                    cell.configure(using: model)
                    return cell
                case let .MainFeedItem(model):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainArticleCell.identifier, for: indexPath) as? MainArticleCell else { return UICollectionViewCell() }
                    cell.configure(using: model)
                    return cell
                case let .FeedItem(model):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsFeedCell.identifier, for: indexPath) as? NewsFeedCell else { return UICollectionViewCell() }
                    cell.configure(using: model)
                    return cell
                }
            }
        )
    }
}
