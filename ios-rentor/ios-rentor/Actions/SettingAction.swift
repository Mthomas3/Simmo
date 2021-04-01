//
//  SettingAction.swift
//  ios-rentor
//
//  Created by Thomas on 01/04/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

internal protocol SettingActionProtocol {
    static var fetch: Self { get }
    static func setHasLaunchedApp(status: Bool) -> Self
}

internal enum SettingsAction: SettingActionProtocol {
    case fetch
    case setHasLaunchedApp(status: Bool)
}
