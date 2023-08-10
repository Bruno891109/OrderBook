//
//  RecentRradeView.swift
//  OrderBook
//
//  Created by MacDev1 on 8/9/23.
//

import SwiftUI

struct RecentTradeView: View {
    @Binding var trades: [OrderModel]
    
    var body: some View {
        VStack {
            HStack {
                Text("Recent Trades")
                Spacer()
            }.padding()
            
            Group{
                Divider()
                HStack {
                    Text("Price (USD)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Qty")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("Total")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .font(.system(size: 12))
                .padding(.horizontal)
                Divider()
                
                
                List {
                    ForEach(trades.indices, id: \.self) { index in
                        DataCellView(order: $trades[index], cellType: .RecentTrade)
                            .listRowSeparator(.hidden)
                    }
                    .frame(maxHeight: 120) // Maximum height for the list content
                }
                
                .environment(\.defaultMinListRowHeight, 16)
                .listStyle(PlainListStyle())
            }
        }
    }
}

struct RecentRradeView_Previews: PreviewProvider {
    static var previews: some View {
        let orders = DataModel.testOrders()
        RecentTradeView(trades: .constant(orders))
        
        
    }
}
