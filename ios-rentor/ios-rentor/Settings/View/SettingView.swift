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
    @State private var helperDataSources: [String] = []
    
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
                Text("1")
                Text("2")
                Text("3")
            }
        }.font(Font.system(size: self.fontSize(for: size)))
        .navigationBarTitle(Text(self.navigationBarTitle), displayMode: .automatic)
        .listStyle(GroupedListStyle())
    }
    
    private func shouldRenderText(with title: String?) -> some View {
        title == nil || title == "" ? AnyView(EmptyView()) : AnyView(Text(title ?? ""))
    }
    
    private func displayHelperSettingProperties() -> some View {
        ForEach
    }
    
    private func displayConfigSettingProperties() -> some View {
        ForEach(self.configDataSources) { cell in
            self.bodyContentCell(with: cell.name, and: cell)
        }.onReceive(self.output.configDataSources) { configDataSources in
            self.configDataSources = configDataSources
        }
    }
    
    private func bodyContentCell(with name: String, and cell: SimmulatorFormCellData) -> some View {
        SimmulatorCellView(with: name, and: cell, with: self.refreshEvent)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
