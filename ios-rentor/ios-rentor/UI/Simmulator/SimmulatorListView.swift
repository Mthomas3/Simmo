//
//  SimmulatorListView.swift
//  ios-rentor
//
//  Created by Thomas on 22/06/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimmulatorListView: View {
    private let navigationBarTitle: String = "Simumation"
    
    @EnvironmentObject private var store: AppStore
    @EnvironmentObject private var modalView: MainTabBarData
    
    @State internal var nextStep: Bool = false
    
    var headerView: some View {
        VStack(alignment: .leading) {
            Button {
                self.modalView.close()
            } label: {
                Text("Fermer")
                    .foregroundColor(Color.white)
            }
            Spacer()
            Text("Ajoutons votre simulation")
                .frame(maxWidth: .infinity, alignment: .leading)
                .ignoresSafeArea()
                .foregroundColor(Color.white)
                .font(.system(size: 36))
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(height: 100, alignment: .leading)
        }.padding(.all, 8)
    }
    
    var SimulatorDivider: some View {
        Divider()
            .background(Color.init("DividerColor"))
            .frame(height: 3, alignment: .center)
            .padding(.leading, 25)
            .padding(.trailing, 25)
    }

    var displayBody: some View {
        ZStack {
            VStack {
                ZStack {
                    Color.init("Blue").edgesIgnoringSafeArea(.all)
                    headerView
                }.frame(height: 130, alignment: .leading)
                .padding(.bottom, 8)
                
                SimulatorRowView(currentEvent: store.state.simulatorState.currentEvent.rawValue,
                                 name: "Information sur le bien",
                                 index: 0,
                                 isChecked: store.state.simulatorState.informations?.isChecked ?? false,
                                 nextPages: AnyView(SimmulatorListView2(shouldPopToRootView: self.$nextStep)))
                SimulatorDivider
                SimulatorRowView(currentEvent:
                                    store.state.simulatorState.currentEvent.rawValue,
                                 name: "Financement", index: 1,
                                 isChecked: store.state.simulatorState.funding?.isChecked ?? false,
                                 nextPages: AnyView(SimulatorFunding0(shouldPopToRootView: self.$nextStep)))
                SimulatorDivider
                SimulatorRowView(currentEvent: store.state.simulatorState.currentEvent.rawValue,
                                 name: "Frais et charges",
                                 index: 2,
                                 isChecked: false,
                                 nextPages: AnyView(SimulatorFee0(shouldPopToRootView: self.$nextStep)))
                SimulatorDivider
                SimulatorRowView(currentEvent: store.state.simulatorState.currentEvent.rawValue,
                                 name: "Fiscalité",
                                 index: 3,
                                 isChecked: false,
                                 nextPages: AnyView(SimulatorTax0(shouldPopToRootView: self.$nextStep)))
                Spacer()
            }
        }.background(Color.init("DefaultBackground").edgesIgnoringSafeArea(.all))
    }

    var body: some View {
        NavigationView {
            displayBody
                .navigationTitle(Text("Retour"))
                .navigationBarHidden(true)
        }
    }
}
