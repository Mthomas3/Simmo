//
//  SimulatorAction.swift
//  ios-rentor
//
//  Created by Thomas on 09/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

internal protocol SimulatorActionProtocol {
    static func setInformations(informations: [String]) -> Self
    static func setFunding(funding: [String]) -> Self
    static func setFees(fees: [String]) -> Self
    static func setTax(tax: [String]) -> Self
}

internal enum SimulatorAction: SimulatorActionProtocol {
    case setInformations(informations: [String])
    case setFunding(funding: [String])
    case setFees(fees: [String])
    case setTax(tax: [String])
}
