//
//  SettingsDBRepository.swift
//  ios-rentor
//
//  Created by Thomas on 20/03/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

protocol SettingsDBRepository {
    var userDefaults: UserDefaults { get set }
    var hasLaunchedApp: Bool { get set }
}

internal final class SettingsDBRepository: SettingsDBRepository {
    var userDefaults: UserDefaults
    
    init(with userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    var hasLaunchedApp: Bool {
        get { return false }
        set { }
    }
}
