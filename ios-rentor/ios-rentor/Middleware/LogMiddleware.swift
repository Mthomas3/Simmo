//
//  LogMiddleware.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import Combine

final class MiddlewareHelper {
    static func logMiddleware() -> Middleware<AppState, AppAction> {
        return { state, action in
            //print("Triggered action: \(action)")
            return Empty().eraseToAnyPublisher()
        }
    }
}
