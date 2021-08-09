//
//  SimulatorReducer.swift
//  ios-rentor
//
//  Created by Thomas on 09/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

final class SimulatorReducer: ReducerProtocol {
    typealias State = SimulatorState
    typealias Action = SimulatorAction
    
    func reducer(state: inout SimulatorState, action: SimulatorAction) {
        switch action {
        case .setInformations(let informations):
            state.informations = informations
        case .setFunding(let funding):
            state.funding = funding
        case .setFees(let fees):
            state.fees = fees
        case .setTax(let tax):
            state.tax = tax
        case .fetchActivitiesCompleted(events: let events):
            state.currentEvent = events
        default: break
        }
    }
}
