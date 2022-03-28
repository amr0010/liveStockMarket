//
//  UIViewExtensions.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 26/03/2022.
//

import UIKit
extension UIView {
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static var nibName: String {
        return String(describing: self)
    }
    
    static var identifier: String {
        return nibName
    }
}
