//
//  SettingCellData.swift
//  ios-rentor
//
//  Created by Thomas on 08/11/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

internal struct SettingCellData: Identifiable {
    let id: UUID = UUID()
    let name: String
    
    internal init(with name: String) {
        self.name = name
    }
}
