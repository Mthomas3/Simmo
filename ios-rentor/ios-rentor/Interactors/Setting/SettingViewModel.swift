//
//  SettingViewModel.swift
//  ios-rentor
//
//  Created by Thomas on 07/11/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

internal struct HelperSettingData: Identifiable {
    let id: UUID = UUID()
    let name: String
    let pathLink: String
    let image: String
    let iconColor: Color
    
    internal init(with name: String, with link: String, and image: String, color: Color) {
        self.name = name
        self.pathLink = link
        self.image = image
        self.iconColor = color
    }
}

internal final class SettingViewModel: ObservableObject, InteractorProtocol {
    
    // MARK: - Private Members
    
    // MARK: Public members
    struct Input {
        
    }
    
    struct Output {
        var configDataSources: AnyPublisher<[SimmulatorFormCellData], Never>
        var helperDataSources: AnyPublisher<[HelperSettingData], Never>
    }
    
    private func createSettingView() -> [SimmulatorFormCellData] {
        [.init(cell: "Taux des prélèvements sociax", with: 20, isPercentage: true),
                                               .init(cell: "Taux de TVA", with: 20, isPercentage: true),
                                               .init(cell: "Taux de TVA", with: 20, isPercentage: true)]
    }
    
    private func createHelperSettingView() -> [HelperSettingData] {
        [.init(with: "Partager", with: "https://mthomas3.github.io", and: "square.and.arrow.up", color: .red),
         .init(with: "Noter l'application", with: "https://mthomas3.github.io", and: "star", color: .yellow),
         .init(with: "Nous contacter", with: "https://mthomas3.github.io", and: "square.and.pencil", color: .green),
         .init(with: "Confidentialité", with: "https://mthomas3.github.io", and: "link", color: .gray)]
    }
    
    func transform(_ input: Input) -> Output {
        
        let configDataSources = Just(self.createSettingView()).eraseToAnyPublisher()
        
        let helperDataSources = Just(self.createHelperSettingView()).eraseToAnyPublisher()
        
        return Output(configDataSources: configDataSources, helperDataSources: helperDataSources)
    }
}
