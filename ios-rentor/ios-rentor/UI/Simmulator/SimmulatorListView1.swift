//
//  SimmulatorListView1.swift
//  ios-rentor
//
//  Created by Thomas on 25/07/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI
import Combine

struct SimmulatorListView1: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            Button(action: {
                isActive = true
            }, label: {
                Text("Continue")
                    .frame(width: 133, height: 56, alignment: .center)
                    .foregroundColor(Color.white)
                    .background(Color.init("PrimaryBlue"))
                    .cornerRadius(12)
            }).buttonStyle(PlainButtonStyle())
            .fullScreenCover(isPresented: $isActive, content: { SimmulatorListView2() })
        }
    }
}

struct SimmulatorListView1_Previews: PreviewProvider {
    static var previews: some View {
        SimmulatorListView1()
    }
}
