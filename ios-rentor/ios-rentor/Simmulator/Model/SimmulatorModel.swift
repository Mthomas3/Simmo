//
//  SimmulatorModel.swift
//  ios-rentor
//
//  Created by Thomas on 23/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine

internal struct SimmulatorFormCellData: Identifiable {
    let name: String
    let value = CurrentValueSubject<Int, Never>(0)
    let id: UUID = UUID()
    
    init(cell name: String) {
        self.name = name
    }
}

internal struct GlobalFormCell: Identifiable {
    let id: UUID = UUID()
    let errorMessage = CurrentValueSubject<String, Never>("")
    let header: String?
    let footer: String?
    let data: [SimmulatorFormCellData]
    
    init(header: String? = nil, footer: String? = nil, data: [SimmulatorFormCellData]) {
        self.header = header
        self.footer = footer
        self.data = data
    }
}
