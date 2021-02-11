//
//  AppState.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

struct AppState {
    var homeState: HomeState
}

struct HomeState {
    var current: [Rentor] = []
    var fetchError: String?
    var fetchInProgress: Bool = false
}
