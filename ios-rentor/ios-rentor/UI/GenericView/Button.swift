//
//  Button.swift
//  ios-rentor
//
//  Created by Thomas on 17/02/2022.
//  Copyright © 2022 Thomas. All rights reserved.
//

import SwiftUI

struct NextButton: View {
    let title: String
    let isHidden: Bool?
    
    var body: some View {
        Text(title)
            .frame(width: 140, height: 56)
            .foregroundColor(Color.white)
            .background(Color.init("Blue")).cornerRadius(12)
            .opacity((isHidden ?? false) ? 0 : 1)
            .padding([.trailing, .bottom], 8)
            .animation(.easeInOut, value: 0.5)
    }
}
