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
}

internal struct SimulatorFunding {
    var isDone: Bool = false
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
    
    init() {
        self.information = SimulatorInformation(type: nil, rented: nil, owner: nil, price: nil, name: nil, color: nil, image: nil, isDone: false)
        self.funding = SimulatorFunding(isDone: false)
    }
    
    internal func saveInformations(with informations: SimulatorInformation) {
        self.information = informations
    }
    
    internal func getInformation() -> SimulatorInformation? {
        return self.information
    }
    
    internal func saveFunding(with funding: SimulatorFunding) {
        self.funding = funding
    }
    
    internal func currentEvent() -> CurrentEvent {
        if self.information.isDone == false {
            return .eventInformation
        } else if self.information.isDone == true &&
                    self.funding.isDone == false {
            return .eventFunding
        }
        return .eventFees
    }
    
    internal func saveFees(with fees: [String]) {
        print("WE SAVE FEES \(fees)")
    }
    
    internal func saveTax(with tax: [String]) {
        print("WE SAVE TAX \(tax)")
    }
}
