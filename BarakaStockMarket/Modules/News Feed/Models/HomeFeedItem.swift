//
//  HomeFeedItem.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 27/03/2022.
//

import Foundation
import RxDataSources

enum HomeFeedSection {
    case stockTicker(title: String, items: [SectionItem])
    case mainFeed(title: String, items: [SectionItem])
    case feed(title: String, items: [SectionItem])
}

enum SectionItem {
    case StockTickerItem(model: StockTicker)
    case MainFeedItem(model: Article)
    case FeedItem(model: Article)
}

extension HomeFeedSection: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch  self {
        case .stockTicker(title: _, items: let items):
            return items.map { $0 }
        case .mainFeed(title: _, items: let items):
            return items.map { $0 }
        case .feed(title: _, items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: HomeFeedSection, items: [Item]) {
        switch original {
        case let .stockTicker(title: title, items: _):
            self = .stockTicker(title: title, items: items)
        case let .mainFeed(title, _):
            self = .mainFeed(title: title, items: items)
        case let .feed(title, _):
            self = .feed(title: title, items: items)
        }
    }
    
}

extension HomeFeedSection {
    var title: String {
        switch self {
        case .stockTicker(title: let title, items: _):
            return title
        case .mainFeed(title: let title, items: _):
            return title
        case .feed(title: let title, items: _):
            return title
        }
    }
}
