//
//  MainView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    fileprivate enum TabState: Int {
        case Home = 0
        case SimmulatorView
        case SettingView
    }
    
    @State var index = 0
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                self.containerView(index: self.index)
            }.padding(.bottom, -35)
            CustomTabs(index: self.$index)
        }
    }
    
    func containerView(index: Int) -> AnyView {
        switch(TabState(rawValue: index)) {
            case .Home:
                return AnyView(Home())
            case .SimmulatorView:
                return AnyView(SimmulatorView())
            case .SettingView:
                return AnyView(SettingView())
            case .none:
                return AnyView(Home())
        }
    }
}

struct Tab: View {
    @Binding var index: Int
    fileprivate var tabState: MainView.TabState
    var imageName: String
    var tabName: String
    
    var body: some View {
        Button(action: {
            self.index = self.tabState.rawValue
           }, label: {
            VStack(alignment: .center, spacing: 5) {
                Image(systemName: imageName)
                    .font(.system(size: 18.0))
                Text(self.tabName)
                    .font(.system(size: 12))
            }
        }).foregroundColor(Color.black.opacity(self.index == self.tabState.rawValue ? 1 : 0.2))
    }
}

struct CustomTabs: View {
    @Binding var index: Int
    
    var body: some View {
        HStack {
            Tab(index: self.$index, tabState: .Home, imageName: "house", tabName: "Home")
            Spacer(minLength: 0)
            Tab(index: self.$index, tabState: .SimmulatorView, imageName: "plus.circle", tabName: "Simmulations")
            Spacer(minLength: 0)
            Tab(index: self.$index, tabState: .SettingView, imageName: "person", tabName: "Settings")
        }
        .padding(.top, 10)
        .padding(.horizontal, 40)
        .background(Color.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
