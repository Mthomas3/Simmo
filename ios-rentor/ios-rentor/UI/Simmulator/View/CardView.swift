//
//  CardView.swift
//  ios-rentor
//
//  Created by Thomas on 04/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

internal enum CardItemType: Int {
    case old = 0
    case new
    case renovate
    case construction
}

struct CardView: View {
    @Binding var cardItem: CardItemType?
    let first_index: Int
    let second_index: Int
    let first_name: String
    let second_name: String
    let first_picture: String
    let second_picture: String
    
    var body: some View {
        HStack {
            Spacer()
            Card(eventSelected: $cardItem,
                     index: first_index,
                     name: first_name,
                     image: first_picture)
            Card(eventSelected: $cardItem,
                     index: second_index,
                     name: second_name,
                     image: second_picture)
            Spacer()
        }
    }
}

struct Card: View {
    
    @EnvironmentObject private var store: AppStore
    @Binding internal var eventSelected: CardItemType?
    internal let index: Int
    internal let name: String
    internal let image: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(eventSelected?.rawValue == index ? Color.init("Blue")
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
                if eventSelected?.rawValue == index {
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
            self.eventSelected = CardItemType(rawValue: index)
        }
    }
}
