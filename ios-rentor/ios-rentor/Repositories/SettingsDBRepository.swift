//
//  SettingsDBRepository.swift
//  ios-rentor
//
//  Created by Thomas on 20/03/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import Combine

internal struct OnBoardingPagesData {
    let title: String
    let image: String
    let content: String
}

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
    
    internal func generateOnBoardPages() -> AnyPublisher<[OnBoardingPagesData], Never> {
        var pages: [OnBoardingPagesData] = []
        pages.append(OnBoardingPagesData(title: "Lorem ipsum", image: "OnBoarding1", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eleifend ultrices tellus non auctor."))
        pages.append(OnBoardingPagesData(title: "Lorem ipsum", image: "OnBoarding2", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eleifend ultrices tellus non auctor."))
        pages.append(OnBoardingPagesData(title: "Lorem ipsum", image: "OnBoarding3", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eleifend ultrices tellus non auctor."))
        
        return Just(pages).eraseToAnyPublisher()
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
