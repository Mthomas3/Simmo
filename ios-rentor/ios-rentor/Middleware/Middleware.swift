//
//  Middleware.swift
//  ios-rentor
//
//  Created by Thomas on 12/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import Combine

internal typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Never>?

internal enum MiddlewareError: Error {
    case unknown
    case networkError
}

internal protocol MiddlewareProtocol {
    associatedtype EntityService: DBRepositoryProtocol
    
    func middleware(service: EntityService) -> Middleware<AppState, AppAction>
}
