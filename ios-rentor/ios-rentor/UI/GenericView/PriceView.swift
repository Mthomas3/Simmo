//
//  PriceView.swift
//  ios-rentor
//
//  Created by Thomas on 17/02/2022.
//  Copyright © 2022 Thomas. All rights reserved.
//

import SwiftUI

struct PriceView: View {
    let title: String
    let placeHolderTextField: String
    @Binding var textfieldValue: String
    @Binding var opacity: Double
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            TextSub(title: title)
            TextField(placeHolderTextField, text: $textfieldValue)
                .textFieldStyle(CustomTextFieldStyle())
        }.onAppear {
            withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                self.opacity = 1
            }
        }
    }
}
