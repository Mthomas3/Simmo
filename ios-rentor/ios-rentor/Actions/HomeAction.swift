//
//  HomeAction.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

internal protocol HomeActionProtocol {
    static var fetch: Self { get }
    static func fetchError(error: MiddlewareError?) -> Self
}

internal enum HomeAction: HomeActionProtocol {
    case fetch
    case setHeaderName(name: String)
    case fetchComplete(home: [Rentor])
    
    case fetchError(error: MiddlewareError?)
    case add(item: Rentor)
    case addError(error: MiddlewareError)
    case delete(item: Rentor)
    case deleteError(error: MiddlewareError)
}
