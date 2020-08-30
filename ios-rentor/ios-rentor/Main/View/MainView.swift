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
        VStack {
            Spacer()
            CustomTabs(index: self.$index)
        }
        .background(Color.black.opacity(0.04).edgesIgnoringSafeArea(.top))
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
            
            Button(action: {
                self.index = 1
                
            }, label: {Image("settings")})
                .foregroundColor(Color.black.opacity(self.index == 1 ? 1 : 0.2))
            
            Spacer(minLength: 0)
            
            Button(action: {},
                   label: { Image("add-circle").renderingMode(.original)})
                .offset(y: -20)
                
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.index = 2

            }, label: {Image("sliders")})
                .foregroundColor(Color.black.opacity(self.index == 2 ? 1 : 0.2))
            
            Spacer(minLength: 0)
            
            Button(action: {
                   self.index = 2

               }, label: {Image("sliders")})
                   .foregroundColor(Color.black.opacity(self.index == 2 ? 1 : 0.2))
            
        }
        .padding(.horizontal, 35)
        .padding(.vertical, 5)
        .background(Color.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
