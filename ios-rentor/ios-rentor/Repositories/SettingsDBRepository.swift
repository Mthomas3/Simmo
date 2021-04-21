//
//  SettingsDBRepository.swift
//  ios-rentor
//
//  Created by Thomas on 20/03/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

internal protocol SettingsDBRepositoryProtocol {
    var userDefaults: UserDefaults { get set }
    var hasLaunchedApp: Bool { get set }
}

internal enum SettingRepositoryKeys: String {
    case hasLaunchedApp
    case numberOfLaunches
}

internal final class SettingsDBRepository: SettingsDBRepositoryProtocol {
    var userDefaults: UserDefaults
    
    init(with userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    var hasLaunchedApp: Bool {
        get { return value(for: SettingRepositoryKeys.hasLaunchedApp.rawValue) ?? false }
        set { updateDefaults(for: SettingRepositoryKeys.hasLaunchedApp.rawValue, value: newValue) }
    }
    
}

extension SettingsDBRepository {
    private func updateDefaults(for key: String, value: Any) {
        userDefaults.set(value, forKey: key)
    }
    
    private func value<T>(for key: String) -> T? {
        return userDefaults.value(forKey: key) as? T
    }
}
