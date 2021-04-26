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
    
    private func drawHeader(with rentor: Rentor) -> some View {
        HStack(alignment: .center) {
            ZStack {
                Color.init("PrimaryBlue")
                Image("Home-appartment")
            }.frame(width: 65, height: 65)
            .cornerRadius(18)
            .padding(.trailing, 10)
            Text("Appartement à Toulouse")
                .font(.title2)
                .fontWeight(.medium)
        }.frame(height: 75)
    }
    
    private func drawSubTitle(with rentor: Rentor) -> some View {
        HStack(alignment: .center) {
            Text("Coût d'acquisition")
            Spacer()
            Text("123 456,78 €")
                .foregroundColor(Color.gray)
        }.frame(height: 50)
    }
    
    private func drawContentTitle(with rentor: Rentor) -> some View {
        HStack(alignment: .center) {
            Text("Rendement brut")
            Spacer()
            Text("5,11 %")
                .foregroundColor(Color.gray)
        }.frame(height: 50)
    }
    
    private func drawContent(with rentor: Rentor) -> some View {
        Text("Le rendement est le niveau de rentabilité d’une some d’argent investie, placée ou de capitaux employés lors d’une opération d’investissement ou de placement. Le rendement brut est le rendement avant impôt et charges.")
            .multilineTextAlignment(.leading)
            .font(.body)
            .frame(height: 140)
            .foregroundColor(Color.gray)
    }
    
    private func drawFooter(with rentor: Rentor) -> some View {
        HStack(alignment: .center) {
            Text("Cash flow")
            Spacer()
            Text("322,57 €")
                .foregroundColor(Color.green)
                .font(.system(size: 28))
                .fontWeight(.medium)
        }.frame(height: 65)
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            self.drawHeader(with: rentor)
            Divider()
                .frame(height: 1).background(Color.init("gray").opacity(0.5))
                .padding(.top, 5)
                .padding(.bottom, 5)
            self.drawSubTitle(with: self.rentor)
            DashedDivider(height: 1, color: Color.init("PrimaryViolet"), opacity: 0.2)
                .padding(.top, 4)
                .padding(.bottom, 4)
            self.drawContentTitle(with: self.rentor)
            self.drawContent(with: self.rentor)
            DashedDivider(height: 1, color: Color.init("PrimaryViolet"), opacity: 0.2)
                .padding(.bottom, 10)
                .padding(.top, 18)
            self.drawFooter(with: self.rentor)
        }.padding(.leading, 12)
        .padding(.trailing, 12)
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(Color.white)
        .cornerRadius(20)
    }
}
