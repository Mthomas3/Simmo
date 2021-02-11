//
//  HomeMiddleware.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import Combine

internal enum HomeMiddlewareError: Error {
    case unknown
    case networkError
}

func homeMiddleware(service: RealRentalDBRepository) -> Middleware<AppState, AppAction> {
    return { state, action in
        switch action {
        case .home(action: .fetch):
            return service.fetch()
                .subscribe(on: DispatchQueue.main)
                .map { AppAction.home(action: .fetchComplete(home: $0)) }
                .catch { (error: CoreDataError) -> Just<AppAction> in
                    switch error {
                    case .unknown:
                        return Just(AppAction.home(action: .fetchError(error: HomeMiddlewareError.unknown)))
                    case .fetchError:
                        return Just(AppAction.home(action: .fetchError(error: HomeMiddlewareError.networkError)))
                    case .updateError:
                        return Just(AppAction.home(action: .fetchError(error: HomeMiddlewareError.networkError)))
                    case .deleteError:
                        return Just(AppAction.home(action: .fetchError(error: HomeMiddlewareError.networkError)))
                    case .createError:
                        return Just(AppAction.home(action: .fetchError(error: HomeMiddlewareError.networkError)))
                    }
                }.eraseToAnyPublisher()
        default:
            break
        }
        return Empty().eraseToAnyPublisher()
    }
}
