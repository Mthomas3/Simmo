//
//  AppReducer.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

typealias Reducer<State, Action> = (inout State, Action) -> Void

internal protocol AppReducerProtocol {
    func reducer(state: inout AppState, action: AppAction)
}

internal final class AppReducer: AppReducerProtocol {
    private let reducer: HomeReducer
    
    init() {
        self.homeReducer = HomeReducer()
    }
    
    func reducer(state: inout AppState, action: AppAction) {
        switch action {
        case .action(action: let action):
            self.homeReducer.reducer(state: &state.homeState, action: action)

        }
    }
}
