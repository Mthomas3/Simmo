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

struct AskButtonView: View {
    @Binding var value: ButtonEventType?
    @Binding var nextButton: Bool
    let first_title: String
    let second_title: String
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            ButtonOption(eventButtonSelect: $value,
                         nextButton: $nextButton,
                         title: first_title, index: 0)
            
            ButtonOption(eventButtonSelect: $value,
                         nextButton: $nextButton,
                         title: second_title, index: 1)
            Spacer()
        }
    }
}
