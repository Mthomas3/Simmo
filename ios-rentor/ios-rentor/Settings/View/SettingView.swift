//
//  SettingView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    //MARK: State
    @State private var dataSources: [SettingCellData] = []
    
    //MARK: ViewModel
    private let settingViewModel: SettingViewModel
    private let output: SettingViewModel.Output
    
    //MARK: Drawing Constants
    private let navigationBarTitle: String = "Setting ⚙️"
    private let fontScaleFactor: CGFloat = 0.04
    
    init() {
        self.settingViewModel = SettingViewModel()
        self.output = self.settingViewModel.transform(SettingViewModel.Input())
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                self.body(with: geometry.size)
            }
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    private func body(with size: CGSize) -> some View {
        List {
            self.displaySettingProperties()
        }.font(Font.system(size: self.fontSize(for: size)))
        .navigationBarTitle(Text(self.navigationBarTitle))
    }
    
    private func displaySettingProperties() -> some View {
        ForEach(self.dataSources) { setting in
            SettingCell(with: setting)
        }.onReceive(self.output.dataSources) { dataSources in
            self.dataSources = dataSources
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
