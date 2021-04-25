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
        HStack(alignment: .center) {
            ZStack {
                Color.init("PrimaryBlue")
                Image("Home-appartment")
            }.frame(width: 65, height: 65)
            .cornerRadius(18)
            .padding(.trailing, 10)
            Text("Appartement à Toulouse")
                .font(.title2)
        }.frame(height: 75)
    }
    
    private func subHeaderTitle(with rental: Rentor) -> some View {
        HStack(alignment: .center) {
            Text("Coût d'acquisition")
            Spacer()
            Text("123 456,78€")
        }.frame(height: 50)
    }
    
    private func anotherSubHeader(with rental: Rentor) -> some View {
        HStack(alignment: .center) {
            Text("Rendement brut")
            Spacer()
            Text("5,11 %")
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
        }.frame(height: 170)
    }
    
    private func testContentCell(with rentor: Rentor) -> some View {
        Text("Le rendement est le niveau de rentabilité d’une some d’argent investie, placée ou de capitaux employés lors d’une opération d’investissement ou de placement. Le rendement brut est le rendement avant impôt et charges.")
            .multilineTextAlignment(.leading)
            .font(.body)
            .frame(height: 120)
    }
    
    private func anotherTestContent(with rentor: Rentor) -> some View {
        HStack(alignment: .center) {
            Text("Cash flow")
            Spacer()
            Text("322,57 €")
                .foregroundColor(Color.green)
        }.frame(height: 50)
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
                .padding(.top, 4)
                .padding(.bottom, 4)
            self.anotherSubHeader(with: self.rentor)
            self.testContentCell(with: rentor)
            CustomDivider(height: 1, color: Color.init("PrimaryViolet"), opacity: 0.2)
                .padding(.bottom, 10)
                .padding(.top, 18)
            self.anotherTestContent(with: rentor)
            //self.contentCell(with: self.rentor)
        }.padding(.leading, 12)
        .padding(.trailing, 12)
        .padding(.top, 8)
        .padding(.bottom, 4)
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
                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [4]))
                .frame(height: 1)
        }.frame(height: height)
        .foregroundColor(color)
        .opacity(opacity)
    }
}
