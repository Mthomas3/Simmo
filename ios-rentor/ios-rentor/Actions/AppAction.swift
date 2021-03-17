//
//  AppAction.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

internal protocol ActionProtocol {
    static func action(action: HomeAction) -> Self
}

internal enum AppAction: ActionProtocol {
    case action(action: HomeAction)
}
