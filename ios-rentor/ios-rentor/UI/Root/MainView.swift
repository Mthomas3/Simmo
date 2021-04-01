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
    private let settingsMiddleware: SettingMiddleware
    private let store: AppStore
    private let appReducer: AppReducer

    init() {
        self.homeMiddleware = HomeMiddleware(with: RealRentalDBRepository())
        self.settingsMiddleware = SettingMiddleware(with: SettingsDBRepository(with: UserDefaults.standard))
        self.appReducer = AppReducer()
        
        self.store = AppStore(initialState: .init(homeState: HomeState(),
                                                  settingsState: SettingsState()),
                              reducer: self.appReducer.reducer(state:action:),
                              middlewares: [self.homeMiddleware.middleware(),
                                            self.settingsMiddleware.middleware(),
                                            MiddlewareHelper.logMiddleware()])
        
        store.dispatch(.homeAction(action: .fetch))
        store.dispatch(.settingsAction(action: .fetch))
        
        store.dispatch(AppAction.settingsAction(action: .setHasLaunchedApp(status: false)))
        print("HAS LAUNCH = \(store.state.settingsState.hasLaunchedApp)")
    }

    var body: some View {        
        TabView {
                HomeContainerView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("house")
                    }
                    .accentColor(.blue)
                    .environmentObject(store)
            SettingView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Setting")
                }.accentColor(.blue)
                .environmentObject(store)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
