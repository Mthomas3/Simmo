//
//  SimulatorAction.swift
//  ios-rentor
//
//  Created by Thomas on 09/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

internal protocol SimulatorActionProtocol {
    static func setInformations(informations: SimulatorInformation) -> Self
    static func setFunding(funding: SimulatorFunding) -> Self
    static func setFees(fees: [String]) -> Self
    static func setTax(tax: [String]) -> Self
}

internal enum SimulatorAction: SimulatorActionProtocol {
    case setInformations(informations: SimulatorInformation)
    case setFunding(funding: SimulatorFunding)
    case setFees(fees: [String])
    case setTax(tax: [String])
    case fetchActivities
    case fetchActivitiesCompleted(events: CurrentEvent)
}
