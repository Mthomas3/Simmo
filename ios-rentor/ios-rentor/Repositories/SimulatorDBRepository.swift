//
//  SimulatorDBRepository.swift
//  ios-rentor
//
//  Created by Thomas on 09/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

internal protocol SimulatorDBRepositoryProtocol { }

internal enum SimulatorType: Int {
    case old
    case new
    case construct
    case renovate
}

internal struct SimulatorInformation {
    var type: SimulatorType?
    var rented: Bool?
    var owner: Bool?
    var price: Double?
    var name: String?
    var color: String?
    var image: String?
    var isDone: Bool = false
    var isChecked: Bool = false
}

internal struct SimulatorFunding {
    var isDone: Bool = false
    var isChecked: Bool = false
    var name: String?
}

internal struct SimulatorFees {
    var isDone: Bool
    var isChecked: Bool
    var name: String?
}

internal struct SimulatorTax {
    var isDone: Bool
    var isChecked: Bool
    var name: String?
}

internal enum CurrentEvent: Int {
    case eventInformation
    case eventFunding
    case eventFees
    case eventTax
}

internal final class SimulatorDBRepository: SimulatorDBRepositoryProtocol {
    
    private var information: SimulatorInformation
    private var funding: SimulatorFunding
    private var fees: SimulatorFees
    private var tax: SimulatorTax
    
    init() {
        self.information = SimulatorInformation(type: nil, rented: nil, owner: nil,
                                                price: nil, name: nil, color: nil, image: nil, isDone: false)
        self.funding = SimulatorFunding(isDone: false)
        self.fees = SimulatorFees(isDone: false, isChecked: false, name: nil)
        self.tax = SimulatorTax(isDone: false, isChecked: false, name: nil)
    }
    
    internal func saveInformations(with informations: SimulatorInformation) {
        self.information = informations
    }
    
    internal func saveFunding(with funding: SimulatorFunding) {
        self.funding = funding
    }
    
    internal func currentEvent() -> CurrentEvent {
        if self.information.isDone == false {
            return .eventInformation
        } else if self.funding.isDone == false {
            return .eventFunding
        } else if self.fees.isDone == false {
            return .eventFees
        }
        return .eventTax
    }
    
    internal func saveFees(with fees: [String]) {
        print("WE SAVE FEES \(fees)")
    }
    
    internal func saveTax(with tax: [String]) {
        print("WE SAVE TAX \(tax)")
    }
}
