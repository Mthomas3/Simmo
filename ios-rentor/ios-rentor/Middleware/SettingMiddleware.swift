//
//  SettingMiddleware.swift
//  ios-rentor
//
//  Created by Thomas on 19/03/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import Combine

final class SettingMiddleware: MiddlewareProtocol {
    
    private let repository: SettingsDBRepository
    
    init(with repository: SettingsDBRepository) {
        self.repository = repository
    }
    
    func middleware() -> Middleware<AppState, AppAction> {
        return { state, action in
            switch action {
            case .settingsAction(action: .fetch):
                return Just(AppAction.settingsAction(action: .setHasLaunchedApp(status:
                                                                                    self.repository.hasLaunchedApp)))
                    .eraseToAnyPublisher()
            case .settingsAction(action: .setHasLaunchedApp(status: let status)):
                self.repository.hasLaunchedApp = status
            default:
                break
            }
            return Empty().eraseToAnyPublisher()
        }
    }
    
}
