//
//  MainArticleCell.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 29/03/2022.
//

import UIKit

class MainArticleCell: UICollectionViewCell {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.lightGray.cgColor
            self.layer.borderWidth = 1
    }
    
    func configure(using article: Article) {
        self.articleTitleLabel.text = article.title
        self.articleImageView.kf.setImage(with: URL(string: article.urlToImage ?? ""))
    }

}
