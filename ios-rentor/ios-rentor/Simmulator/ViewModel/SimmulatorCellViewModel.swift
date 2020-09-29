//
//  SimmulatorCellViewModel.swift
//  ios-rentor
//
//  Created by Thomas on 27/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine

internal class SimmulatorCellViewModel: ViewModelProtocol {
    
    private var disposables = Set<AnyCancellable>()
    
    struct Input {
        var increaseEvent: AnyPublisher<SimmulatorFormCellData, Never>
        var decreaseEvent: AnyPublisher<SimmulatorFormCellData, Never>
    }
    
    struct Output { }
    
    func transform(_ input: Input) -> Output {
                
        input.increaseEvent
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { (cell) in
                self.increaseCell(with: cell)
            }).store(in: &self.disposables)
        
        input.decreaseEvent
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { (cell) in
                self.decreaseCell(with: cell)
            }).store(in: &self.disposables)
        
        return Output()
    }
    
    private func increaseCell(with cell: SimmulatorFormCellData) {
        cell.value.send(cell.value.value + cell.sumIndicator)
    }
    
    private func decreaseCell(with cell: SimmulatorFormCellData) {
        if cell.value.value > 0 {
            cell.value.send(cell.value.value - cell.sumIndicator)
        }
    }
}
