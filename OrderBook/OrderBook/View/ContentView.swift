//
//  ContentView.swift
//  OrderBook
//
//  Created by MacDev1 on 8/9/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selectedSegment = 0
    private let segments = ["Chat", "Oders", "Recent Trades"]
    
    @StateObject private var viewModel = OrderBookViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            VStack {
                DetailView(max_trade_val: $viewModel.max_trade_val, max_buy_val: $viewModel.max_buy_val, last_trade_id: $viewModel.last_trade_id)
                VStack(){
                    HStack(spacing: 0) {
                        Button(action: {
                            self.selectedSegment = 0
                        }) {
                            Text("Chat")
                                .foregroundColor(selectedSegment == 0 ? Color.green : Color.adaptiveBlackColor())
                        }.frame(maxWidth: .infinity)
                        
                        Button(action: {
                            self.selectedSegment = 1
                        }) {
                            Text("Order Book")
                                .foregroundColor(selectedSegment == 1 ? Color.green : Color.adaptiveBlackColor())
                        }.frame(maxWidth: .infinity)
                        
                        Button(action: {
                            self.selectedSegment = 2
                        }) {
                            Text("Recent Trades")
                                .foregroundColor(selectedSegment == 2 ? Color.green : Color.adaptiveBlackColor())
                        }.frame(maxWidth: .infinity)
                    }
                    GeometryReader { geometry in
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color.green)
                            .frame(width: geometry.size.width / 3, alignment: .leading)
                            .offset(x: CGFloat(self.selectedSegment) * (geometry.size.width / 3))
                    }.frame(height: 2)
                }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                if selectedSegment == 0 || selectedSegment == 1 {
                    OrderBookView(buy_trades: $viewModel.buy_trades, sell_trades: $viewModel.sell_trades, max_trade_val: $viewModel.max_trade_val, max_sell_val: $viewModel.max_sell_val ,last_trade_id: $viewModel.last_trade_id)
                }else{
                    RecentTradeView(trades: $viewModel.trades)
                }
                
                Group{
                    VStack(alignment: .leading){
                        HStack {
                            Text("Balance").multilineTextAlignment(.leading)
                        }
                        Divider()
                    }.padding()
                }
                
                Spacer()
                
                Group{
                    VStack{
                        Text("Please log in.")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                        HStack(spacing: 20){
                            Button(action: {
                                print("Button tapped")
                            }) {
                                Text("Log In")
                                    .background(Color.clear)
                                    .foregroundColor(Color.gray)
                                    .frame(width: 100, height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 2))
                            }
                            
                            Button(action: {
                                print("Button tapped")
                            }) {
                                Text("Sign Up")
                                    .background(Color.clear)
                                    .foregroundColor(Color.gray)
                                    .frame(width: 100, height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 2))
                            }
                        }
                    }
                }.padding()
                
                Spacer()
                
                Group{
                    HStack(spacing: 20){
                        Button(action: {
                            print("Button tapped")
                        }) {
                            Text("Buy / Long")
                                .font(.headline)
                                .frame(width: 150, height: 45)
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            print("Button tapped")
                        }) {
                            Text("Sell / Short")
                                .font(.headline)
                                .frame(width: 150, height: 45)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("BTCUSD.PERP")
                            .font(.headline)
                        Image(systemName: "mount.fill")
                            .resizable()
                            .frame(width: 15, height: 20)
                    }
                }
            }
            .navigationBarItems(trailing: Image(systemName: "star.fill")
                .resizable().frame(width: 20, height: 20))
        }
        .onAppear {
            viewModel.startSubscription()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
