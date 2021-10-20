//
//  DoubleExtension.swift
//  web-socket-demo
//
//  Created by Rashid Khan on 10/20/21.
//

import Foundation

extension Double {
    func formate() -> String {
        let formatter = NumberFormatter()
        
        formatter.currencyCode = "USD"
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_GB")
        
        return formatter.string(from: NSNumber(value: self)) ?? "N/A"
    }
}
