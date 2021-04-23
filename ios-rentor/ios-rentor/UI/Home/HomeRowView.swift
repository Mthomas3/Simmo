//
//  HomeRowView.swift
//  ios-rentor
//
//  Created by Thomas on 17/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct HomeRowView: View {
    
    public var rentor: Rentor
    
    private let priceTitle: String = "Prix d'acquisition:"
    private let rentPriceTitle: String = "Loyer mensuel:"
    private let cashFlowTitle: String = "Cash-flow mensuel:"
    private let percentageTitle: String = "Rendement Brut:"
    
    private func headerCell(with name: String) -> some View {
        HStack {
            Image("HomeTabBar")
            Text("Appartement à Toulouse")
                .font(.title2)
        }.frame(height: 50)
    }
    
    private func subHeaderTitle(with rental: Rentor) -> some View {
        HStack {
            Text("Coût d'acquisition")
            Spacer()
            Text("123 456,78€")
        }.frame(height: 50)
    }
    
    private func contentCell(with rental: Rentor) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.priceTitle)
                Text(self.rentPriceTitle)
                Text(self.percentageTitle)
                Text(self.cashFlowTitle)
                    .fontWeight(.medium)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(rental.price)"
                    .numberFormatting(formatterDigit: 2, isDecimal: true)
                    .currencyFormatting())
                    
                Text("\(rental.rentPrice)"
                    .numberFormatting(formatterDigit: 2, isDecimal: true)
                    .currencyFormatting())
                
                Text("\(rental.percentage)"
                    .numberFormatting(formatterDigit: 2, isDecimal: true)
                    .currencyFormatting())
                
                Text("\(rental.cashFlow)"
                    .numberFormatting(formatterDigit: 2, isDecimal: true)
                    .currencyFormatting())
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
        }.frame(height: 150)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            self.headerCell(with: self.rentor.name ?? "")
            Divider()
                .frame(height: 1).background(Color.init("gray").opacity(0.5))
                .padding(.top, 5)
                .padding(.bottom, 5)
            self.subHeaderTitle(with: self.rentor)
            CustomDivider(height: 1, color: Color.init("PrimaryViolet"), opacity: 0.2)
            self.contentCell(with: self.rentor)
        }.padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct CustomDivider: View {
    let height: CGFloat
    let color: Color
    let opacity: Double
    
    var body: some View {
        Group {
            Rectangle()
                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [3]))
                .frame(height: 1)
        }.frame(height: height)
        .foregroundColor(color)
        .opacity(opacity)
    }
}
