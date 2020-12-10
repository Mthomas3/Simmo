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
        
        let a = RentorEntity(context: ((UIApplication.shared.delegate as! AppDelegate).persistentContainer).viewContext)
        a.name = "Je suis un jolie Test"
        a.cashFlow = 1000.0
        a.price = 10000000
        a.createDate = Date()
        a.percentageEffiency = 10.0
        a.rentPrice = 10000.0
        
        _ = CoreDataRental.sharedInstance?.create(with: a)
    }
}
