//
//  MainView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    private let store = AppStore(initialState: .init(homeState: HomeState()),
                                 reducer: appReducer,
                                 middlewares: [homeMiddleware(service:
                                                                RealRentalDBRepository()),
                                                                logMiddleware()])
    init() {
        self.store.dispatch(.home(action: .fetch))
    }
    
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "house")
                Text("house")
            }.accentColor(.blue)
            .environmentObject(store)
            
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
