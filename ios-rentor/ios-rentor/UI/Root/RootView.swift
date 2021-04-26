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
        //CollapsibleDemoView()
    }
}


/* - TMP - */

struct Collapsible<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content
    
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack {
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack {
                        self.label()
                        Spacer()
                        Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
                    }
                    .padding(.bottom, 1)
                    .background(Color.white.opacity(0.01))
                }
            )
            .buttonStyle(PlainButtonStyle())
            
            VStack {
                self.content()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .animation(.easeOut)
            .transition(.slide)
        }
    }
}

struct CollapsibleDemoView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Here we have some fancy text content. Could be whatever you imagine.")
                Spacer()
            }
            .padding(.bottom)
            
            Divider()
                .padding(.bottom)
            
            Collapsible(
                label: { Text("Collapsible") },
                content: {
                    HStack {
                        Text("Content")
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.secondary)
                }
            )
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
/* - END TMP - */

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
                    SettingView()
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
                }.accentColor(Color.init("PrimaryViolet"))
            } else {
                TutorialContainer().environmentObject(store)
            }
        }
    }
}
