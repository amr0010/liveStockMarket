//
//  NewsFeed.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 26/03/2022.
//
import Foundation

// MARK: - FeedsModel
struct FeedsModel: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

// MARK: - Article
struct Article: Codable, Hashable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.publishedAt == rhs.publishedAt
    }
    
    var source: Source?
    var author, title: String?
    var articleDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, content, publishedAt
    }
}

// MARK: - Source
struct Source: Codable, Hashable {
    var id: String?
    var name: String?
}

