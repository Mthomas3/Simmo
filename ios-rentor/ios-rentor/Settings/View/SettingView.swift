//
//  SettingView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI
import Combine

struct SettingView: View {
    
    //MARK: State
    @State private var configDataSources: [SimmulatorFormCellData] = []
    @State private var helperDataSources: [HelperSettingData] = []
    
    //MARK: ViewModel
    private let settingViewModel: SettingViewModel
    private let output: SettingViewModel.Output
    private let refreshEvent = PassthroughSubject<Void, Never>()
    
    //MARK: Drawing Constants
    private let navigationBarTitle: String = "Setting ⚙️"
    private let fontScaleFactor: CGFloat = 0.04
    
    init() {
        self.settingViewModel = SettingViewModel()
        self.output = self.settingViewModel.transform(SettingViewModel.Input())
        
        UITableView.appearance().backgroundColor = UIColor.black.withAlphaComponent(0.05)
        UITableViewCell.appearance().backgroundColor = UIColor.clear
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
            Section(header: Text("CONFIGURATION")) {
                VStack {
                    self.displayConfigSettingProperties()
                }.listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .padding()
                .background(Color.white)
                .cornerRadius(16)
            }.padding(.leading, 8)
            .padding(.trailing, 8)
            Section(header: Text("À PROPOS")) {
                self.displayHelperSettingProperties()
            }
        }.font(Font.system(size: self.fontSize(for: size)))
        .navigationBarTitle(Text(self.navigationBarTitle), displayMode: .automatic)
        .listStyle(GroupedListStyle())
    }
    
    private func shouldRenderText(with title: String?) -> some View {
        title == nil || title == "" ? AnyView(EmptyView()) : AnyView(Text(title ?? ""))
    }
    
    private func displayHelperSettingProperties() -> some View {
        ForEach(self.helperDataSources) { cell in
            HelperSettingCell(with: cell)
        }.onReceive(self.output.helperDataSources) { helperDataSources in
            self.helperDataSources = helperDataSources
        }
    }
    
    private func displayConfigSettingProperties() -> some View {
        ForEach(self.configDataSources) { cell in
            SimmulatorCellView(with: cell.name, and: cell, with: self.refreshEvent)
        }.onReceive(self.output.configDataSources) { configDataSources in
            self.configDataSources = configDataSources
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
