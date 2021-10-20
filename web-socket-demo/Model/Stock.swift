//
//  Stock.swift
//  web-socket-demo
//
//  Created by Rashid Khan on 10/19/21.
//

import Foundation

struct Stock: Codable {
    var isin: String
    var price: Double
    var bid: Double
    var ask: Double
}
