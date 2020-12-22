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

extension Loadable: Equatable where T: Equatable {
    static func == (lhs: Loadable<T>, rhs: Loadable<T>) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested): return true
        case let (.isLoading(lhsV), .isLoading(rhsV)): return lhsV == rhsV
        case let (.loaded(lhsV), .loaded(rhsV)): return lhsV == rhsV
        case let (.failed(lhsE), .failed(rhsE)):
            return lhsE.localizedDescription == rhsE.localizedDescription
        default: return false
        }
    }
}

enum Loadable<T> {
    case notRequested
    case isLoading(value: T)
    case loaded(T)
    case failed(Error)
    
    var value: T? {
        switch self {
        case let .loaded(value): return value
        case let .isLoading(last): return last
        default: return nil
        }
    }
    var error: Error? {
        switch self {
        case let .failed(error): return error
        default: return nil
        }
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
        var onDeleteSource: AnyPublisher<Rentor, Never>
        
        
        var testError: AnyPublisher<Void, Never>
    }
    
    struct Output {
        var dataSources: AnyPublisher<[Rentor], Never>
        var shouldDisplayError: CurrentValueSubject<Bool, Never>
        var messageError: CurrentValueSubject<String, Never>
        var headerListValue: AnyPublisher<String, Never>
        var onUpdate: AnyPublisher<Rentor, Never>
        var testSources: AnyPublisher<[Rentor], CoreDataError>
        var testDisplay: AnyPublisher<String, Never>
    }
    
    init() { }
    
    private func fetchingRentals() -> AnyPublisher<[Rentor], Never> {
        RealRentalDBRepository.sharedInstance.fetch()
            .receive(on: DispatchQueue.main)
            .catch { [weak self] (_) -> AnyPublisher<[Rentor], Never> in
                self?.shouldDisplayError.send(true)
                self?.messageDisplayError.send("An error occured in the fetch")
                return Just([]).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    internal func transform(_ input: Input) -> Output {
        
        let dataSources = self.fetchingRentals()
        
        let onDeleteSources = input.onDeleteSource
            .receive(on: DispatchQueue.main)
            .flatMap { (item) -> AnyPublisher<[Rentor], Never> in
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
