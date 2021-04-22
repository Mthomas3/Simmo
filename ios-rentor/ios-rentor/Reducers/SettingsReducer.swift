//
//  SettingsReducer.swift
//  ios-rentor
//
//  Created by Thomas on 01/04/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

final class SettingsReducer: ReducerProtocol {
    typealias State = SettingsState
    typealias Action = SettingsAction
    
    func reducer(state: inout SettingsState, action: SettingsAction) {
        switch action {
        case .setHasLaunchedApp(status: let status):
            state.hasLaunchedApp = status
        case .setOnBoardingPages(pages: let pages):
            state.onBoardingPages = pages
        default:
            break
        }
    }
}
