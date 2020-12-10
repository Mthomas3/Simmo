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

internal final class HomeViewModel: ObservableObject, ViewModelProtocol {
    
    // MARK: Private Members
    private var disposables = Set<AnyCancellable>()
    private let shouldDisplayError = CurrentValueSubject<Bool, Never>(false)
    private let messageDisplayError = CurrentValueSubject<String, Never>("")
    
    // MARK: Public Members
    struct Input {
        var onDeleteSource: AnyPublisher<RentorEntity, Never>
    }
    
    struct Output {
        var dataSources: AnyPublisher<[RentorEntity], Never>
        var shouldDisplayError: CurrentValueSubject<Bool, Never>
        var messageError: CurrentValueSubject<String, Never>
        var headerListValue: AnyPublisher<String, Never>
        var onUpdate: AnyPublisher<RentorEntity, Never>
    }
    
    init() { }
    
    private func fetchingRentals(with rentalCore: CoreDataRental) -> AnyPublisher<[RentorEntity], Never> {
        rentalCore.fetch()
            .receive(on: DispatchQueue.main)
            .catch { [weak self] (_) -> AnyPublisher<[RentorEntity], Never> in
                self?.shouldDisplayError.send(true)
                self?.messageDisplayError.send("An error occured in the fetch")
                return Just([]).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    internal func transform(_ input: Input) -> Output {
        
        guard let rentalCore = CoreDataRental.sharedInstance else {
            
            return self.transform(input)
        }
        
        let dataSources = self.fetchingRentals(with: rentalCore)
        
        let onDeleteSources = input.onDeleteSource
            .receive(on: DispatchQueue.main)
            .flatMap { (item) -> AnyPublisher<[RentorEntity], Never> in
                do {
                    try CoreDataRental.sharedInstance?.delete(with: item)
                } catch {
                    print("Error on fetch rentals catch = \(error)")
                }
                return self.fetchingRentals(with: rentalCore)
        }
        
        let mergedDataSources = Publishers.Merge(dataSources, onDeleteSources).eraseToAnyPublisher()
        
        let headerListValue = Just("740")
            .map { val in
              "740,00"
            }.eraseToAnyPublisher()
        
        let onUpdate = rentalCore.onUpdate()
        
        return Output(dataSources: mergedDataSources,
                      shouldDisplayError: self.shouldDisplayError,
                      messageError: self.messageDisplayError,
                      headerListValue: headerListValue,
                      onUpdate: onUpdate)
    }
}
