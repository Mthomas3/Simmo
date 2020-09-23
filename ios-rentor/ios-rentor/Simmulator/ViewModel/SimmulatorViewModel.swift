//
//  SimmulatorViewModel.swift
//  ios-rentor
//
//  Created by Thomas on 22/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine

protocol ViewModelProtocol {
    associatedtype Output
    associatedtype Input
    
    func transform(_ input: Input) -> Output
}

internal final class SimmulatorViewModel: ObservableObject, ViewModelProtocol {
    
    private var disposables = Set<AnyCancellable>()

    //MARK: Input
    struct Input {
        var increaseEvent: AnyPublisher<SimmulatorFormCellData?, Never>?
        var decreaseEvent: AnyPublisher<SimmulatorFormCellData?, Never>?
    }
    
    //MARK: Output
    struct Output {
        var dataSources: AnyPublisher<[GlobalFormCell], Never>
        var isFormValid: AnyPublisher<Bool, Never>
    }
    
    internal func transform(_ input: Input) -> Output {
        
        let dataSources = Just(self.initFormViewData())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        let isFormValid = Just(false)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        input.increaseEvent?.receive(on: DispatchQueue.main)
            .sink(receiveValue: { cell in
                guard let cell = cell else { return }
                self.increaseCurrentValue(with: cell)
            }).store(in: &self.disposables)
        
        input.decreaseEvent?.receive(on: DispatchQueue.main)
            .sink(receiveValue: { (cell) in
                guard let cell = cell else { return }
                self.decreaseCurrentValue(with: cell)
            }).store(in: &self.disposables)
        
        return Output(dataSources: dataSources, isFormValid: isFormValid)
    }
    
    private func initFormViewData() -> [GlobalFormCell] {
        [.init(data: [.init(cell: "Prix d'achat"),
                     .init(cell: "Loyer mensuel")]),
        .init(header: "Charges annuelles",
              data: [.init(cell: "Charges locatives"),
                     .init(cell: "Taxe foncière"),
                     .init(cell: "Charges de copropriété"),
                     .init(cell: "Entretien"),
                     .init(cell: "Assurance propriétaire")])]
    }
    
    private func increaseCurrentValue(with cell: SimmulatorFormCellData) {
        cell.value.send(cell.value.value + 1)
    }
    
    private func decreaseCurrentValue(with cell: SimmulatorFormCellData) {
        if cell.value.value > 0 {
            cell.value.send(cell.value.value - 1)
        }
    }
}
