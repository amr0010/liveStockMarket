//
//  DoubleExtensions.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 28/03/2022.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
