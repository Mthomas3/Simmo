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

enum ErrorManager: String {
    case fetchFailure = "An error occured during fetching the data, please try again..."
    case deleteFailure = "An error occured during fetching the data, please try again.."
    case updateFailure = "An error occured during fetching the data, please try again."
}

internal final class HomeViewModel: ObservableObject, InteractorProtocol {
    
    // MARK: Private Members
    private var disposables = Set<AnyCancellable>()
    private let messageDisplayError = CurrentValueSubject<String, Never>("")
    // MARK: Public Members
    struct Input {
        var onDeleteSource: AnyPublisher<Rentor, Never>
    }
    
    struct Output {
        var dataSources: AnyPublisher<[Rentor], Never>
        var headerListValue: AnyPublisher<String, Never>
        var onUpdate: AnyPublisher<Rentor?, Never>
        var errorMessage: AnyPublisher<String, Never>
    }
    
    init() { }
    
    private func fetchingRentals() -> AnyPublisher<[Rentor], Never> {
        RealRentalDBRepository.sharedInstance.fetch()
            .receive(on: DispatchQueue.main)
            .catch { [weak self] (_) -> AnyPublisher<[Rentor], Never> in
                self?.messageDisplayError.send(ErrorManager.fetchFailure.rawValue)
                return Just([]).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    internal func transform(_ input: Input) -> Output {
        
        let dataSources = self.fetchingRentals()
        
        let onDeleteSources = input.onDeleteSource
            .receive(on: DispatchQueue.main)
            .flatMap { (item) -> AnyPublisher<[Rentor], Never> in
                _ = RealRentalDBRepository.sharedInstance.delete(with: item)
                return self.fetchingRentals()
        }
        
        let mergedDataSources = Publishers.Merge(dataSources, onDeleteSources).eraseToAnyPublisher()
        
        let headerListValue = Just("740")
            .map { _ in
              "740,00"
            }.eraseToAnyPublisher()
        
        let onUpdate = RealRentalDBRepository.sharedInstance.refresh()
                
        return Output(dataSources: mergedDataSources,
                      headerListValue: headerListValue,
                      onUpdate: onUpdate,
                      errorMessage: self.messageDisplayError.eraseToAnyPublisher())
    }
}
