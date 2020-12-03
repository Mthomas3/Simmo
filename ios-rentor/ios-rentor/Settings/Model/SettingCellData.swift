//
//  SettingCellData.swift
//  ios-rentor
//
//  Created by Thomas on 08/11/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

internal struct HelperSettingData: Identifiable {
    let id: UUID = UUID()
    let name: String
    let pathLink: String
    let image: String
    let iconColor: Color
    
    internal init(with name: String, with link: String, and image: String, color: Color) {
        self.name = name
        self.pathLink = link
        self.image = image
        self.iconColor = color
    }
}
