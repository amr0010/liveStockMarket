//
//  NewsFeedCell.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 26/03/2022.
//

import UIKit
import Kingfisher
class NewsFeedCell: UICollectionViewCell {

    @IBOutlet weak var feedDescribtionLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedTitleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 1
    }
    
    func configure(using article: Article) {
        self.feedTitleLabel.text = article.title
        self.authorNameLabel.text = article.author
        self.feedDescribtionLabel.text = article.articleDescription
        self.feedImageView.kf.setImage(with: URL(string: article.urlToImage ?? ""))
    }
    

}
