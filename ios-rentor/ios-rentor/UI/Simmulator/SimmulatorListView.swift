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
            HStack {
                Button {
                    self.store.dispatch(.simulatorAction(action: .clear))
                    self.modalView.close()
                } label: {
                    TextWhite(title: "Fermer")
                }
                Spacer()
                Button {
                    if let 💰 = self.store.state.simulatorState.informations {
                        
                        let 🚀 = Rentor(id: UUID(), date: Date(), name: 💰.name,
                                          price: 💰.price ?? 0.0,
                                          rentPrice: 💰.price ?? 0.0,
                                          cashFlow: 💰.price ?? 0.0,
                                          percentage: 💰.price ?? 0.0,
                                          color: 💰.color,
                                          image: 💰.image)
                        
                        print("informations = \(💰)")
                        self.store.dispatch(.homeAction(action: .add(item: 🚀)))
                        self.store.dispatch(.simulatorAction(action: .done))
                    }
                    self.modalView.close()
                } label: {
                    TextWhite(title: "Done")
                }.disabled(!(store.state.simulatorState.currentEvent == .eventDone))
                .opacity(store.state.simulatorState.currentEvent == .eventDone ? 1 : 0)
            }
            Spacer()
            TextTitleModal(title: "Ajoutons votre simulation")
        }.padding(.all, 8)
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
                                 nextPages: AnyView(SimulatorInformation0(shouldPopToRootView: self.$nextStep)))
                CustomDivider()
                SimulatorRowView(currentEvent:
                                    store.state.simulatorState.currentEvent.rawValue,
                                 name: "Financement", index: 1,
                                 isChecked: store.state.simulatorState.funding?.isChecked ?? false,
                                 nextPages: AnyView(SimulatorFunding0(shouldPopToRootView: self.$nextStep)))
                CustomDivider()
                SimulatorRowView(currentEvent: store.state.simulatorState.currentEvent.rawValue,
                                 name: "Frais et charges",
                                 index: 2,
                                 isChecked: store.state.simulatorState.fees?.isChecked ?? false,
                                 nextPages: AnyView(SimulatorFunding0(shouldPopToRootView: self.$nextStep)))
                CustomDivider()
                SimulatorRowView(currentEvent: store.state.simulatorState.currentEvent.rawValue,
                                 name: "Fiscalité",
                                 index: 3,
                                 isChecked: store.state.simulatorState.tax?.isChecked ?? false,
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
