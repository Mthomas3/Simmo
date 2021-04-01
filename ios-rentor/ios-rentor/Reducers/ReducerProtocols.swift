//
//  ReducerProtocols.swift
//  ios-rentor
//
//  Created by Thomas on 01/04/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

typealias Reducer<State, Action> = (inout State, Action) -> Void

internal protocol AppReducerProtocol {
    func reducer(state: inout AppState, action: AppAction)
}

internal protocol ReducerProtocol {
    associatedtype StateType
    associatedtype ActionType
    
    func reducer(state: inout StateType, action: ActionType)
}
