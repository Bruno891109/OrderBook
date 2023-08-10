//
//  OrderModel.swift
//  OrderBook
//
//  Created by MacDev1 on 8/9/23.
//

import Foundation

enum TradeType: String, Codable {
    case Sell
    case Buy
}

struct DataModel: Decodable {
    let table: String
    let action: String
    let data: [OrderModel]
    
    
    static func testOrders() -> [OrderModel] {
        var testOrders = [OrderModel]();
        for _ in 0...50 {
            testOrders.append(OrderModel.testOrder())
        }
        return testOrders
    }
}


struct OrderModel: Codable {
    let symbol: String
    let id: Int
    let side: TradeType
    var size: Double = 0
    let price: Double
    let timestamp: Date
    
    func total() -> Double {
        return price * size
    }
    
    static func testOrder() -> OrderModel {
        return OrderModel(symbol: "XBTUSD", id: 8798040700, side: .Buy, size: 122900, price: 29603.5, timestamp: Date())
    }
}

extension Date {
    func toTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
extension Double {
    func formattedString(style: NumberFormatter.Style = .decimal, maximumFractionDigits: Int = 1) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = style
        numberFormatter.maximumFractionDigits = maximumFractionDigits

        return numberFormatter.string(from: NSNumber(value: self))
    }
}
extension Int {
    func formattedString(style: NumberFormatter.Style = .decimal, maximumFractionDigits: Int = 1) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = style
        numberFormatter.maximumFractionDigits = maximumFractionDigits

        return numberFormatter.string(from: NSNumber(value: self))
    }
}

