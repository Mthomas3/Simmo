//
//  RootView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct RootView: View {

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
    }

    var body: some View {
        BaseView().environmentObject(store)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

struct BaseView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        Group {
            if store.state.settingsState.hasLaunchedApp {
                TabView {
                    
                    HomeContainerView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Mes Simulations")
                        }.environmentObject(store)
                        .accentColor(.blue)
                    
                    SimmulatorView()
                        .tabItem {
                            Image(systemName: "plus.square")
                            Text("Ajouter")
                        }.environmentObject(store)
                        .accentColor(.blue)
                    
                    SettingView()
                        .tabItem {
                            Image(systemName: "slider.horizontal.3")
                            Text("Paramètres")
                        }.environmentObject(store)
                        .accentColor(.blue)
                    
                }.accentColor(Color.init("TabGray"))
                
            } else {
                TutorialContainer().environmentObject(store)
            }
        }.background(Color.yellow)
    }
}
