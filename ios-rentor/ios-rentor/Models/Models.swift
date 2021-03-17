//
//  Models.swift
//  ios-rentor
//
//  Created by Thomas on 21/12/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import SwiftUI

struct Rentor: Identifiable, Equatable, Codable, MockedProtocol {
    var id: UUID
    let date: Date?
    let name: String?
    let price: Double
    let rentPrice: Double
    let cashFlow: Double
    let percentage: Double
    
    init(id: UUID, date: Date?, name: String?,
         price: Double, rentPrice: Double, cashFlow: Double,
         percentage: Double) {
        self.id = id
        self.date = date
        self.name = name
        self.price = price
        self.rentPrice = rentPrice
        self.cashFlow = cashFlow
        self.percentage = percentage
    }
}
