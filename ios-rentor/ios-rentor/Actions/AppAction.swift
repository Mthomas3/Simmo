//
//  AppAction.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

internal protocol ActionProtocol {
    static func homeAction(action: HomeAction) -> Self
    static func settingsAction(action: SettingsAction) -> Self
}

internal enum AppAction: ActionProtocol {
    case homeAction(action: HomeAction)
    case settingsAction(action: SettingsAction)
}
