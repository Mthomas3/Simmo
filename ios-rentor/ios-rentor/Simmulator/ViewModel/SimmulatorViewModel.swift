//
//  SimmulatorViewModel.swift
//  ios-rentor
//
//  Created by Thomas on 22/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

internal final class SimmulatorViewModel: ObservableObject {
    
    //MARK: Input
    @Published var price: String = ""
    @Published var rent: String = ""
    @Published var percentage: String = ""
    
    //MARK: Output
    @Published var isFormValid = false
    
    init() { }
    
    internal func createSimmulation() { }
}
