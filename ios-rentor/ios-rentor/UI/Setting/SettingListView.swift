//
//  SettingListView.swift
//  ios-rentor
//
//  Created by Thomas on 10/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SettingListView: View {
    
    private var item0: [String] = ["Informations personelles",
                                   "Informations financières",
                                   "Notifications"]
    
    private var item1: [String] = ["Conditions générales d'utilisation",
                                   "Politique de confidentialité"]
    
    var body: some View {
        NavigationView {
            settingList
                .navigationBarTitle(Text("Mes paramètres"))
        }
    }
}

extension SettingListView {
    var settingList: some View {
        ZStack {
            Color.init("BackgroundHome")
                .edgesIgnoringSafeArea(.all)
            List {
                Section {
                    ForEach(item0, id: \.self) { name in
                        ZStack(alignment: .leading) {
                            Text(name)
                                .foregroundColor(Color.init("DarkGray"))
                                .fontWeight(.medium)
                            NavigationLink(destination: Text("D")) { EmptyView() }
                        }.frame(height: 46)
                    }
                }.listRowBackground(Color.init("BackgroundHomeCell"))
                
                Section {
                    ForEach(item1, id: \.self) { name in
                        ZStack(alignment: .leading) {
                            Text(name)
                                .foregroundColor(Color.init("DarkGray"))
                                .fontWeight(.medium)
                            NavigationLink(destination: Text("D")) { EmptyView() }
                        }
                    }.frame(height: 46)
                }.listRowBackground(Color.init("BackgroundHomeCell"))
            }.listRowBackground(Color.red)
            .listStyle(InsetGroupedListStyle())
            .listRowInsets(EdgeInsets())    
        }
    }
}

struct SettingListView_Previews: PreviewProvider {
    static var previews: some View {
        SettingListView()
    }
}
