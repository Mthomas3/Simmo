//
//  Text.swift
//  ios-rentor
//
//  Created by Thomas on 16/02/2022.
//  Copyright © 2022 Thomas. All rights reserved.
//

import SwiftUI

struct TextTitleModal: View {
    let title: String
    
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea()
            .foregroundColor(Color.white)
            .font(.system(size: 36))
            .multilineTextAlignment(.leading)
            .lineLimit(2)
            .frame(height: 100, alignment: .leading)
    }
}

struct TextTitle: View {
    let title: String
    var body: some View {
        Text(title)
            .multilineTextAlignment(.leading)
            .lineLimit(3)
            .font(.system(size: 34))
            .padding([.top, .bottom], 8)
            .padding([.trailing, .leading], 24)
    }
}

struct TextSub: View {
    let title: String
    
    var body: some View {
        Text(title)
            .multilineTextAlignment(.leading)
            .lineLimit(3)
            .font(.system(size: 24))
            .padding(.leading, 24)
            .padding([.top, .bottom, .trailing], 4)
    }
}

struct TextWhite: View {
    let title: String
    var body: some View {
        Text(title)
            .foregroundColor(.white)
    }
}
