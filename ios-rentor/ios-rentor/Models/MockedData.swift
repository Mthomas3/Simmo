//
//  MockedData.swift
//  ios-rentor
//
//  Created by Thomas on 21/12/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

#if DEBUG
extension Rentor {
    static let mockedData: [Rentor] = [
        Rentor(id: UUID(), date: Date(), name: "Flat Simmulation",
               price: 120000, rentPrice: 2500, cashFlow: 750, percentage: 5.0, offset: 0, isSwiped: false),
        Rentor(id: UUID(), date: Date(), name: "House Simmulation",
               price: 250000, rentPrice: 4500, cashFlow: 1750, percentage: 10.0, offset: 0, isSwiped: false),
        Rentor(id: UUID(), date: Date(),
               name: "Flat Simmulation", price: 250000, rentPrice: 4500, cashFlow: 750,
               percentage: 3.0, offset: 0, isSwiped: false)
    ]
}
#endif
