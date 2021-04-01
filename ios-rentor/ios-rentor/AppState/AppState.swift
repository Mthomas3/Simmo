//
//  AppState.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import SwiftUI

internal struct AppState {
    var homeState: HomeState
    var settingsState: SettingsState
}

internal struct HomeState {
    var homeRentors: [Rentor] = []
    var headerTitle: String = "0"
    var fetchError: String?
}

internal struct SettingsState {
    var hasLaunchedApp: Bool = false
}
