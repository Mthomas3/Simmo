//
//  RentalEntityView.swift
//  ios-rentor
//
//  Created by Thomas on 04/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

fileprivate struct HeaderView: View {
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(self.name)
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: 0))
                }.stroke()
            }
        }
    }
}

fileprivate struct ContentView: View {
    private let entity: RentorEntity
    
    init(rentor: RentorEntity) {
        self.entity = rentor
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "house").font(.system(size: 26))
                .foregroundColor(Color.black.opacity(0.7))
                .padding(.trailing, 13)
                
            VStack(alignment: .leading) {
                Text("Prix d'acquisition:")
                Text("Loyer mensuel:")
                Text("Cash-flow mensuel:")
                Text("Rendement Brut:")
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(self.entity.price)"
                    .numberFormatting(formatterDigit: 2, isDecimal: true)
                    .currencyFormatting())
                    
                
                Text("\(self.entity.rentPrice)"
                    .numberFormatting(formatterDigit: 2, isDecimal: true)
                    .currencyFormatting())
                    .foregroundColor(.green)
                
                Text("\(self.entity.cashFlow)"
                    .numberFormatting(formatterDigit: 2, isDecimal: true)
                    .currencyFormatting())
                    .foregroundColor(.green)
                
                Text("\(self.entity.percentageEffiency)"
                    .numberFormatting(formatterDigit: 2, isDecimal: true)
                    .currencyFormatting())
                    .foregroundColor(.green)
            }
        }
    }
}

struct RentalEntityView: View {
    var rentor: RentorEntity
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HeaderView(name: rentor.name ?? "")
            ContentView(rentor: self.rentor)
        }
        .padding(.leading, 15)
        .padding(.trailing, 8)
        .padding(.top)
        .padding(.bottom)
        .background(Color.white)
        .cornerRadius(20)
    
    }
}

//struct RentalEntityView_Previews: PreviewProvider {
//    static var previews: some View {
//        let rentor = RentorEntity(
//        RentalEntityView(rentor: <#RentorEntity#>, title: "Test", createDate: "12-03-2002")
//    }
//}
