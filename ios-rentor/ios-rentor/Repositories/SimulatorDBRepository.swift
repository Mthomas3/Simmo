//
//  SimulatorDBRepository.swift
//  ios-rentor
//
//  Created by Thomas on 09/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

internal protocol SimulatorDBRepositoryProtocol { }

internal final class SimulatorDBRepository: SimulatorDBRepositoryProtocol {
    
    internal func saveInformations(with informations: [String]) {
        print("WE SAVE INFORMATIONS \(informations)")
    }
    
    internal func saveFunding(with funding: [String]) {
        print("WE SAVE FUNDING \(funding)")
    }
    
    internal func saveFees(with fees: [String]) {
        print("WE SAVE FEES \(fees)")
    }
    
    internal func saveTax(with tax: [String]) {
        print("WE SAVE TAX \(tax)")
    }
}
