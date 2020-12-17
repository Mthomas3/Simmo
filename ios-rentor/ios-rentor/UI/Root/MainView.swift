//
//  MainView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State private var index = 0
    
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "house")
                Text("house")
            }.accentColor(.blue)
            
            SettingView().tabItem {
                Image(systemName: "person")
                Text("Setting")
            }.accentColor(.blue)
        }.accentColor(Color.init("LightBlue"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
