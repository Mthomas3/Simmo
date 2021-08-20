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
    private let fontScaleFactor: CGFloat = 5
        
    private func drawTitle(with rentor: Rentor) -> some View {
        HStack(alignment: .center) {
            ZStack {
                Color.init(rentor.color ?? "PrimaryBlue")
                Image(rentor.image ?? "Home-appartment")
            }.frame(width: 60, height: 60)
            .cornerRadius(18)
            .padding(.trailing, 10)
            Text(rentor.name ?? "")
                .font(.title3)
                .fontWeight(.medium)
                .font(.system(size: 15))
        }.frame(height: 70)
    }
    
    private func drawPrice(with rentor: Rentor) -> some View {
        HStack(alignment: .center) {
            Text("Coût d'acquisition")
                .font(.system(size: 15))
            Spacer()
            Text("\(rentor.price)".formatPriceWithCurrency())
                .foregroundColor(Color.init("HomeRowFontGray"))
                .font(.system(size: 15))
        }.frame(height: 50)
    }
    
    private func drawNet(with rentor: Rentor) -> some View {
        HStack(alignment: .center) {
            Text("Rendement Net")
                .font(.system(size: 15))
            Spacer()
            Text("1,23 %")
                .foregroundColor(Color.init("HomeRowFontGray"))
                .font(.system(size: 15))
        }.frame(height: 50)
    }
    
    private func drawBrut(with rentor: Rentor) -> some View {
        HStack(alignment: .center) {
            Text("Rendement brut")
                .font(.system(size: 15))
            Spacer()
            Text("5,11 %")
                .foregroundColor(Color.init("HomeRowFontGray"))
                .font(.system(size: 15))
        }.frame(height: 50)
    }
    
    private func drawFooter(with rentor: Rentor) -> some View {
        HStack(alignment: .center) {
            Text("Cash flow")
            Spacer()
            Text("322,57 €")
                .foregroundColor(Color.init("Green"))
                .font(.system(size: 24))
                .fontWeight(.medium)
        }.frame(height: 55)
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                self.drawTitle(with: rentor)
                Divider()
                    .frame(height: 1).background(Color.init("HomeRowFontGray").opacity(0.2))
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                self.drawPrice(with: rentor)
                DashedDivider(height: 1, color: Color.init("HomeRowFontGray"), opacity: 0.2)
                    .padding(.top, 4)
                    .padding(.bottom, 4)
                self.drawBrut(with: rentor)
                DashedDivider(height: 1, color: Color.init("HomeRowFontGray"), opacity: 0.2)
                    .padding(.top, 4)
                    .padding(.bottom, 4)
                self.drawNet(with: rentor)
                DashedDivider(height: 1, color: Color.init("HomeRowFontGray"), opacity: 0.2)
                    .padding(.top, 4)
                    .padding(.bottom, 4)
            }
            VStack(alignment: .leading, spacing: 0) {
                self.drawFooter(with: self.rentor)
            }
        }.padding(.leading, 12)
        .padding(.trailing, 12)
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(Color.init("BackgroundHomeCell"))
        .cornerRadius(20)
    }
}

extension String {
    func formatNumber() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
    
        if let value = Double(self) {
            formatter.string(for: value)
            return "\(value)"
        }
        return ""
    }
    
    func formatPriceWithCurrency() -> String {
        let numberFormatter = NumberFormatter()
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "us_US")
        formatter.groupingSeparator = " "
        formatter.usesGroupingSeparator = true
        formatter.groupingSize = 3
        
        if let value = Double(self), let symbol = Locale.current.currencySymbol {
            numberFormatter.string(for: value)
            return "\(value) \(symbol)".replacingOccurrences(of: ".", with: ",")
        }
        return ""
    }
}
