//
//  HomeReducer.swift
//  ios-rentor
//
//  Created by Thomas on 12/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import SwiftUI

internal protocol ReducerProtocol {
    associatedtype StateType
    associatedtype ActionType
    
    func reducer(state: inout StateType, action: ActionType)
}

final class HomeReducer: ReducerProtocol {
    
    typealias State = HomeState
    typealias Actin = HomeAction
    
    func reducer(state: inout HomeState, action: HomeAction) {
        switch action {
        case .fetch:
            state.fetchError = nil
            state.fetchInProgress = true
            
        case .fetchComplete(let home):
            state.fetchInProgress = false
            state.current = home
            state.headerTitle = "20.0$"
            
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
}
