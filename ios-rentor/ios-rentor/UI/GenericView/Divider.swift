//
//  Divider.swift
//  ios-rentor
//
//  Created by Thomas on 17/02/2022.
//  Copyright © 2022 Thomas. All rights reserved.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Divider()
            .background(Color.init("DividerColor"))
            .frame(height: 3, alignment: .center)
            .padding(.leading, 25)
            .padding(.trailing, 25)
    }
}
