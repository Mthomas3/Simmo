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
        var configDataSources: AnyPublisher<[SimmulatorFormCellData], Never>
        var helperDataSources: AnyPublisher<[String], Never>
    }
    
    private func createSettingView() -> [SimmulatorFormCellData] {
        [.init(cell: "Taux des prélèvements sociax", with: 20, isPercentage: true),
                                               .init(cell: "Taux de TVA", with: 20, isPercentage: true),
                                               .init(cell: "Taux de TVA", with: 20, isPercentage: true)]
    }
    
    private func createHelperSettingView() -> [String] {
        return ["TEST A", "TEST B", "TEST C"]
    }
    
    func transform(_ input: Input) -> Output {
        
        let configDataSources = Just(self.createSettingView()).eraseToAnyPublisher()
        
        let helperDataSources = Just(self.createHelperSettingView()).eraseToAnyPublisher()
        
        return Output(configDataSources: configDataSources, helperDataSources: helperDataSources)
    }
}
