//
//  TextFieldCustomView.swift
//  ios-rentor
//
//  Created by Thomas on 16/02/2022.
//  Copyright © 2022 Thomas. All rights reserved.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding([.leading, .top, .bottom], 8)
            .padding(.trailing, 12)
            .frame(height: 56)
            .cornerRadius(20)
            .font(.system(size: 24))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.init("DarkGray"), lineWidth: 1))
            .padding(.leading, 24)
            .padding(.trailing, 24)
            .multilineTextAlignment(.trailing)
    }
}
