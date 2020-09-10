//
//  RentalEntityView.swift
//  ios-rentor
//
//  Created by Thomas on 04/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct RentalEntityView: View {
    var rentor: RentorEntity
    
    var body: some View {
        
        HStack(spacing: 18) {
            Image(systemName: "house").font(.system(size: 30)).foregroundColor(Color.black.opacity(0.7))
            VStack(alignment: .leading) {
                Text("Prix d'acquisition:")
                Text("Loyer mensuel:")
                Text("Cash-flow mensuel")
                Text("Rendement Brut:")
            }
            Spacer()
            VStack {
                Text(rentor.price ?? "")
                Text(rentor.cashFlow ?? "").foregroundColor(.green)
                Text(rentor.cashFlow ?? "").foregroundColor(.green)
                Text(rentor.percentageEffiency ?? "").foregroundColor(.green)
            }
        }
        .padding()
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
