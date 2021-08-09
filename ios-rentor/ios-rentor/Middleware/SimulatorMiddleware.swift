//
//  SimulatorMiddleware.swift
//  ios-rentor
//
//  Created by Thomas on 09/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import Combine

final class SimulatorMiddleware: MiddlewareProtocol {
    private let repository: SimulatorDBRepository
    
    init(with repository: SimulatorDBRepository) {
        self.repository = repository
    }
    
    func middleware() -> Middleware<AppState, AppAction> {
        return { state, action in
            switch action {
            case .simulatorAction(action: .setInformations(informations: let informations)):
                self.repository.saveInformations(with: informations)
            case .simulatorAction(action: .setFunding(funding: let funding)):
                self.repository.saveFunding(with: funding)
            case .simulatorAction(action: .setFees(fees: let fees)):
                self.repository.saveFees(with: fees)
            case .simulatorAction(action: .setTax(tax: let tax)):
                self.repository.saveTax(with: tax)
            default: break
            }
            return Empty().eraseToAnyPublisher()
        }
    }
}
