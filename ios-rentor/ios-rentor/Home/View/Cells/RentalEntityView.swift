//
//  RentalEntityView.swift
//  ios-rentor
//
//  Created by Thomas on 04/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct RentalEntityView: View {
    var title: String
    var createDate: String
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(title)
                    .font(.custom("HelveticaNeue-Medium", size: 14))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text(createDate)
                    .font(.custom("HelveticaNeue-Medium", size: 14))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
            }.background(Color.red)
        }.background(Color.black)
    }
}

struct RentalEntityView_Previews: PreviewProvider {
    static var previews: some View {
        RentalEntityView(title: "Test", createDate: "12-03-2002")
    }
}
