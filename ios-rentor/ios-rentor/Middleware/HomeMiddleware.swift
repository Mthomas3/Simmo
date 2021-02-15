//
//  HomeMiddleware.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import Combine

final class HomeMiddleware: MiddlewareProtocol {
    internal typealias EntityService = RealRentalDBRepository
    
    private func fetchHome(with service: RealRentalDBRepository) -> AnyPublisher<AppAction, Never> {
        return service.fetch()
            .subscribe(on: DispatchQueue.main)
            .map { AppAction.action(action: .fetchComplete(home: $0))}
            .catch {(error: CoreDataError) -> Just<AppAction> in
                switch error {
                case .fetchError:
                    return Just(AppAction.action(action: .fetchError(error: MiddlewareError.unknown)))
                default:
                    return Just(AppAction.action(action: .fetchError(error: MiddlewareError.unknown)))
                }
            }.eraseToAnyPublisher()
            
    }
    
    internal func middleware(service: RealRentalDBRepository) -> Middleware<AppState, AppAction> {
        return { state, action in
            switch action {
            case .action(action: .fetch):
                return self.fetchHome(with: service)
            default:
                break
            }
            return Empty().eraseToAnyPublisher()
        }
    }
}
