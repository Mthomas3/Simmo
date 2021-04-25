//
//  View+Ext.swift
//  ios-rentor
//
//  Created by Thomas on 25/04/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

internal struct DashedDivider: View {
    let height: CGFloat
    let color: Color
    let opacity: Double
    
    var body: some View {
        Group {
            Rectangle()
                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [4]))
                .frame(height: 1)
        }.frame(height: height)
        .foregroundColor(color)
        .opacity(opacity)
    }
}
