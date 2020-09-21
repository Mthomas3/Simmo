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

internal final class HomeViewModel: ObservableObject {
    
    //MARK: Public Members
    @Published private(set) var dataSources: [RentorEntity] = []
    internal let shouldDisplayError = CurrentValueSubject<Bool, Never>(false)
    internal let messageDisplayError = CurrentValueSubject<String, Never>("")
    
    //MARK: Private Members
    private var disposables = Set<AnyCancellable>()
    
    init() {
        self.fetchRentals()
    }
    
    private func fetchRentals() {
        CoreDataManager.sharedInstance.fetchData(type: RentorEntity.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (value) in
                guard let self = self else { return }
                switch value {
                case .failure(_):
                    self.dataSources = []
                    self.shouldDisplayError.send(true)
                    self.messageDisplayError.send("Cannot fetch rentals properties")
                    break
                case .finished:
                    break
                }
            }) { [weak self] (items) in
                guard let self = self, let items = items else { return }
                self.dataSources = items
        }.store(in: &self.disposables)
    }
    
    internal func deleteRentals(with index: Int) {
        CoreDataManager.sharedInstance.deleteData(with: self.dataSources[index])
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (value) in
                guard let self = self else { return }
                switch value {
                case .failure(_):
                    self.shouldDisplayError.send(true)
                    self.messageDisplayError.send("Cannot delete this rental property")
                    break
                case .finished:
                    break
                }
            }) { [weak self] _ in
                guard let self = self else { return }
                self.dataSources.remove(at: index)
        }.store(in: &self.disposables)
    }
}
