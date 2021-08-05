//
//  CardView.swift
//  ios-rentor
//
//  Created by Thomas on 04/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @Binding internal var eventSelected: Int?
    internal let index: Int
    internal let name: String
    internal let image: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(eventSelected == index ? Color.init("Blue")
                                : Color.init("cardBorderLine"), lineWidth: 2)
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .foregroundColor(Color.init("DefaultBackground")))
            VStack {
                Image(image)
                    .resizable()
                    .frame(width: 105, height: 105, alignment: .center)
                Text(name)
                    .foregroundColor(Color.init("DarkGray"))
                    .fontWeight(.medium)
            }
            Group {
                if eventSelected == index {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Spacer()
                            Image("cornerImage")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        Spacer()
                    }.cornerRadius(12)
                }
            }
        }.frame(width: 170, height: 220)
        .onTapGesture {
            self.eventSelected = index
        }
    }
}
