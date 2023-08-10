//
//  OrderBookViewModel.swift
//  OrderBook
//
//  Created by MacDev1 on 8/9/23.
//

import Foundation
import SwiftUI

class OrderBookViewModel: ObservableObject {
    @Published var trades: [OrderModel] = []
    @Published var buy_trades: [OrderModel] = []
    @Published var sell_trades: [OrderModel] = []
    @Published var max_trade_val: Double = 0
    @Published var max_sell_val: Double = 0
    @Published var max_buy_val: Double = 0
    @Published var last_trade_id: Int = 0
    
    var webSocketHandler: WebSocketHandler!
    func startSubscription() {
        webSocketHandler = WebSocketHandler(url: URL(string: "wss://ws.bitmex.com/realtime?subscribe=instrument,orderBookL2_25:XBTUSD")!)
        webSocketHandler.delegate = self
        webSocketHandler.connect()
    }
}

extension OrderBookViewModel: WebSocketHandlerDelegate {
    func didReceiveMessage(_ message: String) {
        // Handle received message
        print("Received message: \(message)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let jsonData = message.data(using: .utf8) {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let trade = try decoder.decode(DataModel.self, from: jsonData)
                let sortedArray = trade.data.sorted { (object1, object2) in
                    return object1.timestamp > object2.timestamp
                }
                
                DispatchQueue.main.async { [self] in
                    let maxCount = 30
                    for order in sortedArray {
                        if max_trade_val < order.total() {
                            max_trade_val = order.total()
                        }
                        if last_trade_id < order.id {
                            last_trade_id = order.id
                        }
                        if order.side == .Buy {
                            if max_buy_val < order.price {
                                max_buy_val = order.price
                            }
                            self.buy_trades = Array(([order] + self.buy_trades).prefix(maxCount))
                        }else if order.side == .Sell {
                            if max_sell_val < order.price {
                                max_sell_val = order.price
                            }
                            self.sell_trades = Array(([order] + self.sell_trades).prefix(maxCount))
                        }
                        
                    }
                    self.trades = Array((sortedArray + self.trades).prefix(maxCount))
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }

    // Implement other delegate methods as needed
}
