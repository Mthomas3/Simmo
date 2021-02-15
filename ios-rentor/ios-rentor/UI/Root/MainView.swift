//
//  MainView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    private let homeMiddleware: HomeMiddleware
    private let store: AppStore
    private let appReducer: AppReducer
    
    init() {
        self.homeMiddleware = HomeMiddleware()
        self.appReducer = AppReducer()
        
        self.store = AppStore(initialState: .init(homeState: HomeState()),
                              reducer: self.appReducer.reducer(state:action:),
                               middlewares: [self.homeMiddleware.middleware(service: RealRentalDBRepository()),
                                             MiddlewareHelper.logMiddleware()])
        
        self.store.dispatch(.action(action: .fetch))
    }
    
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "house")
                Text("house")
            }.accentColor(.blue)
            .environmentObject(self.store)
            
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
