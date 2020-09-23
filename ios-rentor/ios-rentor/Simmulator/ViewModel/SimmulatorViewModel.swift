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
        [.init(header: "Header Test A",
              data: [.init(cell: "Price A"),
                     .init(cell: "Rent A"),
                     .init(cell: "Percentage A")]),
        .init(header: "Header Test B",
              data: [.init(cell: "Price B"),
                     .init(cell: "Rent B"),
                     .init(cell: "Percentage B")])]
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
