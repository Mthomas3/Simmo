//
//  SettingCellData.swift
//  ios-rentor
//
//  Created by Thomas on 08/11/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine

internal struct SharedSettingData: Identifiable {
    let id: UUID = UUID()
    let name: String
    let pathLink: String
    
    internal init(with name: String, with link: String) {
        self.name = name
        self.pathLink = link
    }
}
