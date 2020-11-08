//
//  SettingViewModel.swift
//  ios-rentor
//
//  Created by Thomas on 07/11/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine

internal final class SettingViewModel: ObservableObject, ViewModelProtocol {
    
    //MARK: Private Members
    
    //MARK: Public members
    struct Input {
        
    }
    
    struct Output {
        var dataSources: AnyPublisher<[SettingCellData], Never>
    }
    
    private func createSettingView() -> [SettingCellData] {
        var data: [SettingCellData] = []
        
        data.append(SettingCellData(with: "TEST A"))
        data.append(SettingCellData(with: "TEST B"))
        
        return data
    }
    
    func transform(_ input: Input) -> Output {
        
        let dataSources = Just(self.createSettingView())
            .eraseToAnyPublisher()
        
        return Output(dataSources: dataSources)
    }
}
