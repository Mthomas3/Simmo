//
//  SimmulatorViewModel.swift
//  ios-rentor
//
//  Created by Thomas on 22/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine

internal final class SimmulatorViewModel: ObservableObject {
    //MARK: Input
    @Published var dataSources: [GlobalFormCell] = []

    //MARK: Output
    @Published var isFormValid: Bool = false
    @Published var formErrorMessage: String = ""
    
    enum actionEvent: Int {
        case price
        case rent
        case percentage
    }
    
    private func initFormViewData() -> [GlobalFormCell] {
        [.init(data: [.init(cell: "Prix d'achat"),
                     .init(cell: "Loyer mensuel")]),
        .init(header: "Charges annuelles",
              data: [.init(cell: "Charges locatives"),
                     .init(cell: "Taxe foncière"),
                     .init(cell: "Charges de copropriété"),
                     .init(cell: "Entretien"),
                     .init(cell: "Assurance propriétaire")])]
    }
    
    init() {
        self.dataSources = self.initFormViewData()
    }
    
    internal func createSimmulation() { }
    
    internal func increaseCurrentValue(with cell: SimmulatorFormCellData) {
        cell.value.send(cell.value.value + 1)
    }
    
    internal func decreaseCurrentValue(with cell: SimmulatorFormCellData) {
        if cell.value.value > 0 {
            cell.value.send(cell.value.value - 1)
        }
    }
    
}
