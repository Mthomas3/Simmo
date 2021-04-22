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
    
    private func fetchOnBoardingPages() -> AnyPublisher<AppAction, Never> {
        return self.repository.generateOnBoardPages()
            .subscribe(on: DispatchQueue.main)
            .flatMap { (onBoardingPages)  in
                Just(AppAction.settingsAction(action: .setOnBoardingPages(pages: onBoardingPages)))
            }.eraseToAnyPublisher()
    }
    
    private func fetchHasLaunchedApp() -> AnyPublisher<AppAction, Never> {
        return Just(AppAction.settingsAction(
                        action: .setHasLaunchedApp(status: self.repository.hasLaunchedApp))).eraseToAnyPublisher()
    }
    
    func middleware() -> Middleware<AppState, AppAction> {
        return { state, action in
            switch action {
            case .settingsAction(action: .fetch):
                return Publishers.Merge(self.fetchHasLaunchedApp(), self.fetchOnBoardingPages()).eraseToAnyPublisher()
            case .settingsAction(action: .setHasLaunchedApp(status: let status)):
                self.repository.hasLaunchedApp = status
            default:
                break
            }
            return Empty().eraseToAnyPublisher()
        }
    }
    
}
