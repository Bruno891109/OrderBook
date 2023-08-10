//
//  OrderBookApp.swift
//  OrderBook
//
//  Created by MacDev1 on 8/9/23.
//

import SwiftUI

@main
struct OrderBookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
