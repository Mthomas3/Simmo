//
//  HomeMiddleware.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import Combine

var launch: Bool = false

final class HomeMiddleware: MiddlewareProtocol {
    internal typealias EntityService = RealRentalDBRepository
    
    private func fetchHome(with service: RealRentalDBRepository) -> AnyPublisher<AppAction, Never> {
        return service.fetch()
            .subscribe(on: DispatchQueue.main)
            .map {
                return AppAction.action(action: .fetchComplete(home: $0))
            }.catch {(error: CoreError) -> Just<AppAction> in
                switch error {
                case .fetchCoreError, .fetchMockedError:
                    return Just(AppAction.action(action: .fetchError(error: MiddlewareError.fetchError)))
                default:
                    return Just(AppAction.action(action: .fetchError(error: MiddlewareError.unknown)))
                }
            }.eraseToAnyPublisher()
    }
    
    private func createProperty(with service: RealRentalDBRepository,
                                new item: Rentor) -> AnyPublisher<AppAction, Never> {
        return service.create(with: item)
            .map {
                return AppAction.action(action: .fetch)
            }.catch { (error: CoreError) -> Just<AppAction> in
                switch error {
                case .createMockedError, .createCoreError:
                    return Just(AppAction.action(action: .fetchError(error: MiddlewareError.createError)))
                default:
                    return Just(AppAction.action(action: .fetchError(error: MiddlewareError.unknown)))
                }
            }.eraseToAnyPublisher()
    }
    
    private func deleteProperty(with service: RealRentalDBRepository,
                                delete item: Rentor) -> AnyPublisher<AppAction, Never> {
        return service.delete(with: item)
            .map {
                return AppAction.action(action: .fetch)
            }.catch { (error: CoreError) -> Just<AppAction> in
                switch error {
                case .deleteCoreError, .deleteMockedError:
                    return Just(AppAction.action(action: .fetchError(error: MiddlewareError.deleteError)))
                default:
                    return Just(AppAction.action(action: .fetchError(error: MiddlewareError.unknown)))
                }
            }.eraseToAnyPublisher()
    }
    
    private func fetchSomethingHeader() -> AnyPublisher<AppAction, Never> {
        var value = launch ? "10000":"0"
        launch = !launch
        return Just(AppAction.action(action: .setHeaderName(name: value))).eraseToAnyPublisher()
    }
    
    internal func middleware(service: RealRentalDBRepository) -> Middleware<AppState, AppAction> {
        return { state, action in
            switch action {
            case .action(action: .fetch):
                return self.fetchHome(with: service).merge(with: self.fetchSomethingHeader()).eraseToAnyPublisher()
            case .action(action: .add(item: let newRentor)):
                return self.createProperty(with: service, new: newRentor)
            case .action(action: .delete(item: let deleteItem)):
                return self.deleteProperty(with: service, delete: deleteItem)
            default:
                break
            }
            return Empty().eraseToAnyPublisher()
        }
    }
}
