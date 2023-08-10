//
//  DetailView.swift
//  OrderBook
//
//  Created by MacDev1 on 8/9/23.
//

import SwiftUI

struct DetailView: View {
    @Binding var max_trade_val: Double
    @Binding var max_buy_val: Double
    @Binding var last_trade_id: Int
    
    var body: some View {
        HStack{
            VStack{
                HStack{
                    HStack{
                        Text(max_buy_val.formattedString()!)
                        Image(systemName: "arrow.up")
                    }
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(.green)
                    VStack{
                        HStack{
                            Image(systemName: "arrowtriangle.up.fill")
                            Text("1,429.8")
                        }
                        HStack{
                            Image(systemName: "plus")
                            Text("2.84%")
                        }
                    }
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.green)
                }
            }
            Spacer()
            HStack{
                VStack(alignment: .leading){
                    Text("Index").multilineTextAlignment(.leading)
                    Text("Mark").multilineTextAlignment(.trailing)
                }
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.gray)
                VStack(alignment: .trailing){
                    Text(last_trade_id.formattedString()!).multilineTextAlignment(.leading)
                    Text(max_trade_val.formattedString()!).multilineTextAlignment(.trailing)
                }
                .font(.system(size: 12, weight: .medium))
            }
        }.padding()
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(max_trade_val: .constant(2348724), max_buy_val: .constant(1237294), last_trade_id: .constant(334729))
    }
}
