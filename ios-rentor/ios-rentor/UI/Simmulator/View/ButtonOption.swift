//
//  ButtonOption.swift
//  ios-rentor
//
//  Created by Thomas on 03/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct ButtonOption: View {
    @Binding internal var eventButtonSelect: Int?
    @Binding internal var nextButton: Bool
    internal let title: String
    internal let index: Int
    
    var body: some View {
        Button(action: {
            self.eventButtonSelect = self.index
            if !self.nextButton {
                self.nextButton.toggle()    
            }
        }, label: {
            Group {
                if self.eventButtonSelect == index {
                    Text(self.title)
                        .frame(width: 155, height: 56)
                        .foregroundColor(Color.init("DarkGray"))
                        .background(Color.init("Blue"))
                        .cornerRadius(12)
                } else {
                    Text(self.title)
                        .frame(width: 155, height: 56)
                        .foregroundColor(Color.init("DarkGray"))
                        .background(Color.init("DefaultBackground"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 2).foregroundColor(Color.init("ButtonBorder")))
                }
            }
        })
    }
}
