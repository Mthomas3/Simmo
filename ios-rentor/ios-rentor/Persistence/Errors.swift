//
//  Errors.swift
//  ios-rentor
//
//  Created by Thomas on 21/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

internal enum CoreError: Error, CaseIterable {
    
    case fetchCoreError
    case updateCoreError
    case deleteCoreError
    case createCoreError
    
    case fetchMockedError
    case updateMockedError
    case deleteMockedError
    case createMockedError
    
    case unknown
}
