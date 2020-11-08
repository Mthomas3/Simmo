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
        var dataSources: AnyPublisher<[GlobalFormCell], Never>
    }
    
    private func createSettingView() -> [GlobalFormCell] {
        [.init(header: "CONFIGURATIOn", data: [.init(cell: "Taux des prélèvements sociax", with: 20, isPercentage: true),
                                               .init(cell: "Taux de TVA", with: 20, isPercentage: true),
                                               .init(cell: "Taux de TVA", with: 20, isPercentage: true)])]
    }
    
    func transform(_ input: Input) -> Output {
        
        let dataSources = Just(self.createSettingView())
            .eraseToAnyPublisher()
        
        return Output(dataSources: dataSources)
    }
}
