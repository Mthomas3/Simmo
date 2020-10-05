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
    
    //MARK: Private Members
    private var disposables = Set<AnyCancellable>()
    private let shouldDisplayError = CurrentValueSubject<Bool, Never>(false)
    private let messageDisplayError = CurrentValueSubject<String, Never>("")
    
    //MARK: Public Members
    struct Input {
        var onDeleteSource: AnyPublisher<RentorEntity, Never>
    }
    
    struct Output {
        var dataSources: AnyPublisher<[RentorEntity], Never>
        var shouldDisplayError: CurrentValueSubject<Bool, Never>
        var messageError: CurrentValueSubject<String, Never>
    }
    
    init() { }
    
    private func fetchingRentals() -> AnyPublisher<[RentorEntity], Never> {
        CoreDataManager.sharedInstance.fetchData(type: RentorEntity.self)
            .receive(on: DispatchQueue.main)
            .map { $0 ?? [] }
            .catch { [weak self] (error) -> AnyPublisher<[RentorEntity], Never> in
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
                    try CoreDataManager.sharedInstance.deleteRental(type: RentorEntity.self, with: item)
                } catch {
                    print("Error on fetch rentals catch = \(error)")
                }
                return self.fetchingRentals()
        }
        
        let mergedDataSources = Publishers.Merge(dataSources, onDeleteSources).eraseToAnyPublisher()
        
        return Output(dataSources: mergedDataSources,
                      shouldDisplayError: self.shouldDisplayError,
                      messageError: self.messageDisplayError)
    }
}
