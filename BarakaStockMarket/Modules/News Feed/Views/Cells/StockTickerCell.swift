//
//  StockTickerCell.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 26/03/2022.
//

import UIKit

class StockTickerCell: UICollectionViewCell {
    
    @IBOutlet weak var priceContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var price: Double = 0 {
        didSet {
            self.priceLabel.text = "\(price.rounded(toPlaces: 2)) USD"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        priceContainerView.layer.cornerRadius = 10
    }
    
    func configure(using ticker: StockTicker) {
        self.nameLabel.text = ticker.stock
        self.price = ticker.price
        changeBackgroundColor()
    }
    
    private func changeBackgroundColor() {
        priceContainerView.backgroundColor = price > 0 ? .green : .red
    }
    
}
