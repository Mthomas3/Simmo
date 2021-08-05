//
//  SimmulatorListView3.swift
//  ios-rentor
//
//  Created by Thomas on 03/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .cornerRadius(20)
            //.font(Font.system(size: 15, weight: .medium, design: .serif))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.init("DarkGray"), lineWidth: 1))
            .padding(.leading, 24)
            .padding(.trailing, 24)
            .frame(height: 56)
    }
}

struct TextView: View {
    @State internal var name: String = ""
    
    var body: some View {
        TextField("1 200 000 €", text: $name)
            .multilineTextAlignment(.trailing)
            .textFieldStyle(OvalTextFieldStyle())
            .padding(.leading, 24)
            .padding(.trailing, 24)
            .frame(height: 56)
    }
}

struct SimmulatorListView3: View {
    
    @State internal var isCurrentSelected: Int?
    @State internal var nextButton: Bool = false
    
    var body: some View {
        ZStack {
            Color.init("BackgroundHome").edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 8) {
                Text("Êtes-vous propriétaire de ce bien?")
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .font(.system(size: 34))
                    .frame(height: 140)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                
                HStack(alignment: .center) {
                    Spacer()
                    ButtonOption(eventButtonSelect: self.$isCurrentSelected,
                                 nextButton: self.$nextButton, title: "Oui", index: 0)
                    ButtonOption(eventButtonSelect: self.$isCurrentSelected,
                                 nextButton: self.$nextButton, title: "Non", index: 1)
                    Spacer()
                }
                
                Text("Quel est le prix du bien?")
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .font(.system(size: 24))
                    .padding(.all, 24)
                
                TextView()
                    
                
                Spacer()
            }
        }
    }
}

struct SimmulatorListView3_Previews: PreviewProvider {
    static var previews: some View {
        SimmulatorListView3()
    }
}
