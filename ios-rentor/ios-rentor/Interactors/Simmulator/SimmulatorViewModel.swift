//
//  SimmulatorViewModel.swift
//  ios-rentor
//
//  Created by Thomas on 22/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

internal final class SimmulatorViewModel: ObservableObject, InteractorProtocol {
    
    private var disposables = Set<AnyCancellable>()
    
    // MARK: Input
    struct Input {
        var doneForm: AnyPublisher<Void, Never>
        var refreshEvent: AnyPublisher<Void, Never>
    }
    
    // MARK: Output
    struct Output {
        var dataSources: AnyPublisher<[GlobalFormCell], Never>
        var isFormValid: AnyPublisher<Bool, Never>
    }
    
    private func initFormViewData() -> [GlobalFormCell] {
        [.init(data: [.init(cell: "Prix d'achat", with: 10000, isPercentage: false),
                      .init(cell: "Loyer mensuel", isPercentage: false)]),
        .init(header: "Charges annuelles",
              data: [.init(cell: "Charges locatives", isPercentage: false),
                     .init(cell: "Taxe foncière", isPercentage: false),
                     .init(cell: "Charges de copropriété", isPercentage: false),
                     .init(cell: "Entretien", isPercentage: false),
                     .init(cell: "Assurance propriétaire", isPercentage: false)]),
        .init(header: "Taxes annuelles",
              data: [.init(cell: "Charges", isPercentage: false),
                     .init(cell: "Entretien", isPercentage: false)])]
    }
    
    internal func transform(_ input: Input) -> Output {
        let dataSources = Just(self.initFormViewData())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        var isFormValid = Just(false)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        input.doneForm.receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.handleDoneFormEvent()
            }).store(in: &self.disposables)
        isFormValid = Publishers.CombineLatest(input.refreshEvent, dataSources)
            .debounce(for: 0.1, scheduler: DispatchQueue.main)
            .map { !($0.1.filter { $0.data.filter { $0.value.value == 0 }.count > 0 }.count > 0)
            }.receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        return Output(dataSources: dataSources, isFormValid: isFormValid)
    }
    
    private func handleDoneFormEvent() {
        /*_ = RealRentalDBRepository.sharedInstance
            .create(with:
                        Rentor(date: Date(), name: "MEGA TEST", price: 250000,
                               rentPrice: 10000, cashFlow: 2500, percentage: 30, offset: 0, isSwiped: false))*/
    }
}
