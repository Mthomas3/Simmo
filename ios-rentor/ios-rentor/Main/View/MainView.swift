//
//  MainView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var index = 0
    
    var body: some View {
            
        VStack(spacing: 0) {
            ZStack {
                if self.index == 0 {
                    DisplaySimulations()
                } else if self.index == 1 {
                    SimmulatorView()
                } else if self.index == 2 {
                    SettingView()
                }
                
            }.padding(.bottom, -35)
            CustomTabs(index: self.$index)
        }
    }
}

struct CustomTabs: View {
    @Binding var index: Int
    
    var body: some View {
        HStack {
            Button(action: {
                self.index = 0
                
            }, label: {Image("sliders")})
                .foregroundColor(Color.black.opacity(self.index == 0 ? 1 : 0.2))
            
            Spacer(minLength: 0)
            
            Button(action: { self.index = 1 },
                   label: { Image("plus-circle-light").renderingMode(.original)})
                .offset(y: -30)
                
            Spacer(minLength: 0)
            
            Button(action: {
                   self.index = 2
               }, label: {Image("settings")})
                   .foregroundColor(Color.black.opacity(self.index == 2 ? 1 : 0.2))
        }
        .padding(.horizontal, 70)
        .padding(.top, 35)
        .padding(.vertical, 5)
        .background(Color.white)
        //.clipShape(CShape())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
