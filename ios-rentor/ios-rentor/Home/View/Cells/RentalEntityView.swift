//
//  RentalEntityView.swift
//  ios-rentor
//
//  Created by Thomas on 04/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI
import Combine

struct RentalContentView: View {
    private let rentalData: RentorEntity
    
    //MARK: Drawing Constants
    private let priceTitle: String = "Prix d'acquisition:"
    private let rentPriceTitle: String = "Loyer mensuel:"
    private let cashFlowTitle: String = "Cash-flow mensuel:"
    private let percentageTitle: String = "Rendement Brut:"
    
    init(with rental: RentorEntity) {
        self.rentalData = rental
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            self.HeaderCell(with: self.rentalData.name ?? "")
            self.ContentCell(with: self.rentalData)
        }.padding()
        .background(Color.white)
        .cornerRadius(20)
    }
    
    private func HeaderCell(with name: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(name) 👏")
                .font(.system(size: 18))
                .fontWeight(.bold)
            Divider()
                .frame(height: 2).background(Color.init("Blue").opacity(0.5))
                .padding(.top, 5)
                .padding(.bottom, 5)
        }
    }
    
    private func ContentCell(with rental: RentorEntity) -> some View {
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
                
                Text("\(rental.percentageEffiency)"
                    .numberFormatting(formatterDigit: 2, isDecimal: true)
                    .currencyFormatting())
                
                Text("\(rental.cashFlow)"
                    .numberFormatting(formatterDigit: 2, isDecimal: true)
                    .currencyFormatting())
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
        }
    }
}
