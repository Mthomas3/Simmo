//
//  HomeViewModel.swift
//  ios-rentor
//
//  Created by Thomas on 20/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import CoreData
import Combine

internal struct ErrorDisplay {
    let isDisplayed: Bool
    let errorMessage: String
    
    init(display: Bool, messsage: String) {
        self.isDisplayed = display
        self.errorMessage = messsage
    }
}

internal final class HomeViewModel: ObservableObject, InteractorProtocol {
    
    // MARK: Private Members
    private var disposables = Set<AnyCancellable>()
    private let shouldDisplayError = CurrentValueSubject<Bool, Never>(false)
    private let messageDisplayError = CurrentValueSubject<String, Never>("")
    private let shouldTestErrorDisplay = PassthroughSubject<String, Never>()
    
    // MARK: Public Members
    struct Input {
        var onDeleteSource: AnyPublisher<RentorEntity, Never>
        
        
        var testError: AnyPublisher<Void, Never>
    }
    
    struct Output {
        var dataSources: AnyPublisher<[RentorEntity], Never>
        var shouldDisplayError: CurrentValueSubject<Bool, Never>
        var messageError: CurrentValueSubject<String, Never>
        var headerListValue: AnyPublisher<String, Never>
        var onUpdate: AnyPublisher<RentorEntity, Never>
        var testSources: AnyPublisher<[RentorEntity], CoreDataError>
        var testDisplay: AnyPublisher<String, Never>
    }
    
    init() { }
    
    private func fetchingRentals() -> AnyPublisher<[RentorEntity], Never> {
        RealRentalDBRepository.sharedInstance.fetch()
            .receive(on: DispatchQueue.main)
            .catch { [weak self] (_) -> AnyPublisher<[RentorEntity], Never> in
                self?.shouldDisplayError.send(true)
                self?.messageDisplayError.send("An error occured in the fetch")
                return Just([]).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    internal func transform(_ input: Input) -> Output {
        
        let dataSources = self.fetchingRentals()
        
        let onDeleteSources = input.onDeleteSource
            .receive(on: DispatchQueue.main)
            .flatMap { (item) -> AnyPublisher<[RentorEntity], Never> in
                do {
                    try RealRentalDBRepository.sharedInstance.delete(with: item)
                } catch {
                    print("Error on fetch rentals catch = \(error)")
                }
                return self.fetchingRentals()
        }
        
        let mergedDataSources = Publishers.Merge(dataSources, onDeleteSources).eraseToAnyPublisher()
        
        let headerListValue = Just("740")
            .map { _ in
              "740,00"
            }.eraseToAnyPublisher()
        
        let onUpdate = RealRentalDBRepository.sharedInstance.refresh()
        
        let testSources = RealRentalDBRepository.sharedInstance.fetch()
        
        input.testError.receive(on: DispatchQueue.main)
            .sink(receiveValue: { (_) in
                self.shouldTestErrorDisplay.send("THE ERORR IS HERE MDR YO")
            }).store(in: &self.disposables)
        
        let errorDisplay = ErrorDisplay(display: true, messsage: "yesssssss")
        
        self.shouldTestErrorDisplay.send("THE ERROR IS HERE MDR YO")
        
        return Output(dataSources: mergedDataSources,
                      shouldDisplayError: self.shouldDisplayError,
                      messageError: self.messageDisplayError,
                      headerListValue: headerListValue,
                      onUpdate: onUpdate, testSources: testSources,
                      testDisplay: self.shouldTestErrorDisplay.eraseToAnyPublisher())
    }
}
