//
//  RootView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI
import Combine

final class MainTabBarData: ObservableObject {

    let customActionteminidex: Int
    let objectWillChange = PassthroughSubject<MainTabBarData, Never>()

    var itemSelected: Int {
        didSet {
            if itemSelected == customActionteminidex {
                itemSelected = oldValue
                isCustomItemSelected = true
            }
            objectWillChange.send(self)
        }
    }
    
    internal func close() {
        self.isCustomItemSelected = false
        self.itemSelected = 1
    }
    
    var isCustomItemSelected: Bool = false

    init(initialIndex: Int = 1, customItemIndex: Int) {
        self.customActionteminidex = customItemIndex
        self.itemSelected = initialIndex
    }
}

struct RootView: View {

    private let homeMiddleware: HomeMiddleware
    private let settingsMiddleware: SettingMiddleware
    private let simulatorMiddleware: SimulatorMiddleware
    private let store: AppStore
    private let appReducer: AppReducer

    init() {
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
        self.homeMiddleware = HomeMiddleware(with: RealRentalDBRepository())
        self.settingsMiddleware = SettingMiddleware(with: SettingsDBRepository(with: UserDefaults.standard))
        self.simulatorMiddleware = SimulatorMiddleware(with: SimulatorDBRepository())
        self.appReducer = AppReducer()
        
        self.store = AppStore(initialState: .init(homeState: HomeState(),
                                                  settingsState: SettingsState(),
                                                  simulatorState: SimulatorState()),
                              reducer: self.appReducer.reducer(state:action:),
                              middlewares: [self.homeMiddleware.middleware(),
                                            self.settingsMiddleware.middleware(),
                                            self.simulatorMiddleware.middleware(),
                                            MiddlewareHelper.logMiddleware()])
        
        store.dispatch(.homeAction(action: .fetch))
        store.dispatch(.settingsAction(action: .fetch))
        store.dispatch(.homeAction(action: .add(item: Rentor(id: UUID(), date: Date(), name: "YOLO", price: 130.0, rentPrice: 30.0, cashFlow: 30.0, percentage: 20.0))))
    }

    var body: some View {
        BaseView().environmentObject(store)
    }
}

struct BaseView: View {
    @EnvironmentObject var store: AppStore
    @ObservedObject private var tabData = MainTabBarData(initialIndex: 1, customItemIndex: 2)

    var body: some View {
        Group {
            if store.state.settingsState.hasLaunchedApp {
                TabView(selection: $tabData.itemSelected) {
                    HomeContainerView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Mes Simulations")
                        }.environmentObject(store)
                        .accentColor(.blue)
                        .tag(1)
                    
                    Text("Custom Action")
                    .tabItem {
                        Image(systemName: "plus.square")
                        Text("Ajouter")
                    }.tag(2)
                    
                    SettingView()
                        .tabItem {
                            Image(systemName: "slider.horizontal.3")
                            Text("Paramètres")
                        }.environmentObject(store)
                        .accentColor(.blue)
                        .tag(3)
                    
                }.accentColor(Color.init("TabGray"))
                .fullScreenCover(isPresented: $tabData.isCustomItemSelected) {
                    SimmulatorContainer()
                        .environmentObject(tabData)
                        .environmentObject(store)
                    }
            } else {
                TutorialContainer().environmentObject(store)
            }
        }
    }
}
