//
//  Storyboarded.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 26/03/2022.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let Nib = UINib(nibName: id, bundle: nil)
        return Nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
}
