//
//  SimmulatorViewModel.swift
//  ios-rentor
//
//  Created by Thomas on 22/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine

internal final class SimmulatorViewModel: ObservableObject, ViewModelProtocol {
    
    private var disposables = Set<AnyCancellable>()
    
    //MARK: Input
    struct Input {
        var doneForm: AnyPublisher<Void, Never>
        var refreshEvent: AnyPublisher<Void, Never>
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
        
        var isFormValid = Just(false)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        input.doneForm.receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                //print("Input done trigger")
            }).store(in: &self.disposables)
        
        isFormValid = Publishers.CombineLatest(input.refreshEvent, dataSources)
            .debounce(for: 0.1, scheduler: DispatchQueue.main)
            .map { !($0.1.filter { $0.data.filter { $0.value.value == 0 }.count > 0 }.count > 0)
            }.receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
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
}
