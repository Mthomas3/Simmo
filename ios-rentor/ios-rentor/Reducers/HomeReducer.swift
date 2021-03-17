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
        case .fetchComplete(let rentors):
            state.homeRentors = rentors
        case .setHeaderName(name: let name):
            state.headerTitle = name
        default:
            break
        }
    }
}
