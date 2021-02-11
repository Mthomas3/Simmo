//
//  HomeReducer.swift
//  ios-rentor
//
//  Created by Thomas on 12/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

func homeReducer(state: inout HomeState, action: HomeAction) {
    switch action {
    case .fetch:
        state.fetchError = nil
        state.fetchInProgress = true
        
    case .fetchComplete(let home):
        state.fetchInProgress = false
        state.current = home
        
    case .fetchError(let error):
        state.fetchInProgress = false
        
        switch error {
        case .networkError:
                state.fetchError = "Opps. ERROR NETWORK"
        default:
                state.fetchError = "ERROR UNKNOWN"
        }
    }
}
