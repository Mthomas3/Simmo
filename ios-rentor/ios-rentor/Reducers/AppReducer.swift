//
//  AppReducer.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

internal final class AppReducer: AppReducerProtocol {
    private let homeReducer: HomeReducer
    private let settingReducer: SettingsReducer
    private let simulatorReducer: SimulatorReducer
    
    init() {
        self.homeReducer = HomeReducer()
        self.settingReducer = SettingsReducer()
        self.simulatorReducer = SimulatorReducer()
    }
    
    func reducer(state: inout AppState, action: AppAction) {
        switch action {
        case .homeAction(action: let action):
            self.homeReducer.reducer(state: &state.homeState, action: action)
        case .settingsAction(action: let action):
            self.settingReducer.reducer(state: &state.settingsState, action: action)
        case .simulatorAction(action: let action):
            self.simulatorReducer.reducer(state: &state.simulatorState, action: action)
        }
    }
}
