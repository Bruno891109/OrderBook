//
//  OderBookView.swift
//  OrderBook
//
//  Created by MacDev1 on 8/9/23.
//

import SwiftUI

struct OderBookHeaderView: View {
    
    @State private var selectedOption = 0
    private let options = ["0.1", "0.2", "0.3"]
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                HStack{
                    Text("Order Book")
                    Picker("Select an option", selection: $selectedOption) {
                        ForEach(options.indices, id: \.self) { index in
                            Text(options[index])
                                .tag(index)
                                .foregroundColor(Color.adaptiveBlackColor())
                        }
                    }
                    .accentColor(Color.adaptiveBlackColor())
                    .frame(height: 20)
                    .pickerStyle(MenuPickerStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .background(Color(.systemGray6))
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Button(action: {
                    print("Button tapped")
                }) {
                    Text("USD")
                        .padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                }
                .frame(height: 25)
            }
        }.padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)).font(.system(size: 12))
    }
}

struct OrderMarkView: View {
    var max_sell_val: Double
    var last_trade_id: Int
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Text(String(max_sell_val))
                    Image(systemName: "arrow.up")
                }
                .foregroundColor(.green)
                Text(String(last_trade_id)).multilineTextAlignment(.leading)
                Text("Mark").multilineTextAlignment(.leading)
            }
        }
        .font(.system(size: 14))
    }
}


struct OrderBookView: View {
    @Binding var buy_trades: [OrderModel]
    @Binding var sell_trades: [OrderModel]
    @Binding var max_trade_val: Double
    @Binding var max_sell_val: Double
    @Binding var last_trade_id: Int
    
    var body: some View {
        VStack(spacing: 8){
            OderBookHeaderView()
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
                    ForEach(buy_trades.indices, id: \.self) { index in
                        let trade = buy_trades[index]
                        let colorPercent = trade.total() / max_trade_val
                        DataCellView(order: $buy_trades[index], cellType: .OrderBook, textColors: [Color.red, Color.adaptiveBlackColor(), Color.adaptiveBlackColor()], backClor: Color.red, colorPecent: colorPercent)
                            .listRowSeparator(.hidden)
                    }
                    .frame(maxHeight: 80) // Maximum height for the list content
                }
                
                .environment(\.defaultMinListRowHeight, 16)
                .listStyle(PlainListStyle())
            }
            
            Group{
                Divider()
                OrderMarkView(max_sell_val: max_sell_val, last_trade_id: last_trade_id)
                Divider()
                
                List {
                    ForEach(sell_trades.indices, id: \.self) { index in
                        let trade = sell_trades[index]
                        let colorPercent = trade.total() / max_trade_val
                        DataCellView(order: $sell_trades[index], cellType: .OrderBook,  textColors: [Color.green, Color.adaptiveBlackColor(), Color.adaptiveBlackColor()],backClor: Color.green, colorPecent: colorPercent)
                            .listRowSeparator(.hidden)
                    }
                    .frame(maxHeight: 80) // Maximum height for the list content
                }
                
                .environment(\.defaultMinListRowHeight, 16)
                .listStyle(PlainListStyle())
            }
            
            
        }
        
    }
}

struct OderBookView_Previews: PreviewProvider {
    static var previews: some View {
        let orders = DataModel.testOrders()
        OrderBookView(buy_trades: .constant(orders), sell_trades: .constant(orders), max_trade_val: .constant(10000000000), max_sell_val: .constant(321984) ,last_trade_id: .constant(1234556))
    }
}
