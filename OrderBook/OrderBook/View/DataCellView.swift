//
//  DataCellView.swift
//  OrderBook
//
//  Created by MacDev1 on 8/9/23.
//

import SwiftUI

enum CELLTYPE{
    case OrderBook
    case RecentTrade
}

struct DataCellView: View {
    
    @Binding var order: OrderModel
    
    var cellType: CELLTYPE
    var textColors: [Color] = [Color.adaptiveBlackColor(), Color.adaptiveBlackColor(), Color.adaptiveBlackColor()]
    var backClor: Color = Color.clear
    var colorPecent: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 12) {
            Text(order.price.formattedString()!)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(textColors[0])
            Text(order.size.formattedString()!)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(textColors[1])
            if cellType == .RecentTrade {
                Text(order.timestamp.toTimeString())
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(textColors[2])
            }else{
                ZStack{
                    GeometryReader { geometry in
                        HStack {
                            Color.clear
                                .frame(width: geometry.size.width * (1 - colorPecent), height: geometry.size.height)
                            
                            backClor.opacity(0.8)
                                .frame(width: geometry.size.width * colorPecent, height: geometry.size.height)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    Text(order.total().formattedString()!)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(textColors[2])
                }
            }
        }
        .font(.system(size: 12))
        .frame(maxHeight:22)
        .listRowInsets(EdgeInsets())
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
        
        
    }
}

struct DataCellView_Previews: PreviewProvider {
    static var previews: some View {
        let order = OrderModel.testOrder()
        DataCellView(order: .constant(order), cellType: .RecentTrade)
    }
}
extension Color {
    static func adaptiveBlackColor() -> Color {
        return Color("BLACK")
    }
}
