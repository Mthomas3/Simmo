//
//  Errors.swift
//  ios-rentor
//
//  Created by Thomas on 21/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

internal enum CoreDataError: Error {
    case fetchError
    case updateError
    case deleteError
    case createError
}
