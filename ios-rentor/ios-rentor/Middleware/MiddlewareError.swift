//
//  MiddlewareError.swift
//  ios-rentor
//
//  Created by Thomas on 15/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

internal enum MiddlewareError: Error {
    case unknown
    case networkError
    case deleteError
    case updateError
}
