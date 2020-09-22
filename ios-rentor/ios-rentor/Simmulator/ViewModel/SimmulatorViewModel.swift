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
    @Published var price: Int = 0
    @Published var rent: String = ""
    @Published var percentage: String = ""
    
    //MARK: Output
    @Published var isFormValid: Bool = false
    @Published var formErrorMessage: String = ""
    
    init() {
        $price.sink { (value) in
            print("vm = \(value)")
        }
    }
    
    internal func createSimmulation() { }
}
