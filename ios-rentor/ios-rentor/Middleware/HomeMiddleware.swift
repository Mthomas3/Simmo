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
    private let homeRepository: RealRentalDBRepository
    
    init(with repository: RealRentalDBRepository) {
        self.homeRepository = repository
    }
    
    private func numberX(value: [Rentor]) -> String {
        return "\(value.map { $0.cashFlow }.reduce(0,{$0 + $1}))"
    }
    
    private func fetchHome() -> AnyPublisher<AppAction, Never> {
        return self.homeRepository.fetch()
            .subscribe(on: DispatchQueue.main)
            .flatMap { (value: [Rentor]) in
            return Publishers.Merge(Just(AppAction.homeAction(action:
                                                            .setHeaderName(name: self.numberX(value: value)))),
                                    Just(AppAction.homeAction(action: .fetchComplete(home: value))))
        }.catch { (error: CoreError) -> Just<AppAction> in
            switch error {
            case .fetchCoreError, .fetchMockedError:
                return Just(AppAction.homeAction(action: .fetchError(error: .fetchError)))
            default:
                return Just(AppAction.homeAction(action: .fetchError(error: .unknown)))
            }
        }.eraseToAnyPublisher()
    }
    
    private func createProperty(new item: Rentor) -> AnyPublisher<AppAction, Never> {
        return self.homeRepository.create(with: item)
            .map {
                return AppAction.homeAction(action: .fetch)
            }.catch { (error: CoreError) -> Just<AppAction> in
                switch error {
                case .createMockedError, .createCoreError:
                    return Just(AppAction.homeAction(action: .fetchError(error: MiddlewareError.createError)))
                default:
                    return Just(AppAction.homeAction(action: .fetchError(error: MiddlewareError.unknown)))
                }
            }.eraseToAnyPublisher()
    }
    
    private func deleteProperty(delete item: Rentor) -> AnyPublisher<AppAction, Never> {
        return self.homeRepository.delete(with: item)
            .map {
                return AppAction.homeAction(action: .fetch)
            }.catch { (error: CoreError) -> Just<AppAction> in
                switch error {
                case .deleteCoreError, .deleteMockedError:
                    return Just(AppAction.homeAction(action: .fetchError(error: MiddlewareError.deleteError)))
                default:
                    return Just(AppAction.homeAction(action: .fetchError(error: MiddlewareError.unknown)))
                }
            }.eraseToAnyPublisher()
    }
    
    internal func middleware() -> Middleware<AppState, AppAction> {
        return { state, action in
            switch action {
            case .homeAction(action: .fetch):
                return self.fetchHome()
            case .homeAction(action: .add(item: let newRentor)):
                return self.createProperty(new: newRentor)
            case .homeAction(action: .delete(item: let deleteItem)):
                return self.deleteProperty(delete: deleteItem)
            default:
                break
            }
            return Empty().eraseToAnyPublisher()
        }
    }
}
