//
//  ButtonOption.swift
//  ios-rentor
//
//  Created by Thomas on 03/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct ButtonOption: View {
    @Binding internal var isButtonSelected: Bool
    @Binding internal var isCurrentSelected: Int
    
    let title: String
    
    var body: some View {
        return Button(action: {
            print("yo button is trigger")
            //self.isCurrentSelected = index
            //self.isButtonSelected.toggle()
        }, label: {
            /*Group {
                if isButtonSelected && isCurrentSelected == index {
                    Text(title)
                        .frame(width: 155, height: 56)
                        .foregroundColor(Color.init("DarkGray"))
                        .background(Color.init("Blue"))
                        .cornerRadius(12)
                } else {
                    Text(title)
                        .frame(width: 155, height: 56)
                        .foregroundColor(Color.init("DarkGray"))
                        .background(Color.init("DefaultBackground"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 2).foregroundColor(Color.init("ButtonBorder")))
                }
            }*/
            Text("YO")
        })
    }
}
