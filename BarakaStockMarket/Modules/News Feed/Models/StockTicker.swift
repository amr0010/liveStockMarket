//
//  StockTicker.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 26/03/2022.
//

import Foundation

struct StockTicker: BaseModel, Hashable {
    static func == (lhs: StockTicker, rhs: StockTicker) -> Bool {
        lhs.uuid == rhs.uuid
    }
    var price: Double
    let stock: String
    let uuid: String
    
    enum CodingKeys: String, CodingKey {
        case stock = "STOCK"
        case price = "PRICE"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let stringPrice = try container.decode(String.self, forKey: .price)
        self.price = Double(stringPrice) ?? 0
        self.stock = try container.decode(String.self, forKey: .stock)
        self.uuid = UUID().uuidString
    }
}
