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
    
    @EnvironmentObject internal var store: AppStore
    @EnvironmentObject internal var modalView: MainTabBarData
    
    @State internal var nextStep: Bool = false
    
    var headerView: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    self.store.dispatch(.simulatorAction(action: .clear))
                    self.modalView.close()
                } label: {
                    TextWhite(title: Constant.title_close)
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
                        
                        self.store.dispatch(.homeAction(action: .add(item: 🚀)))
                        self.store.dispatch(.simulatorAction(action: .done))
                    }
                    self.modalView.close()
                } label: {
                    TextWhite(title: Constant.title_done)
                }.disabled(!(store.state.simulatorState.currentEvent == .eventDone))
                .opacity(store.state.simulatorState.currentEvent == .eventDone ? 1 : 0)
            }
            Spacer()
            TextTitleModal(title: Constant.title_simulator_container_view)
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
                
                SimulatorRowView(currentViewType: store.state.simulatorState.currentEvent,
                                 name: Constant.title_information_container,
                                 typeView: .eventInformation,
                                 isChecked: store.state.simulatorState.informations?.isChecked ?? false,
                                 nextPages: AnyView(SimulatorInformation0(shouldPopToRootView: self.$nextStep)))
                CustomDivider()
                SimulatorRowView(currentViewType:
                                    store.state.simulatorState.currentEvent,
                                 name: Constant.title_funding_container, typeView: .eventFunding,
                                 isChecked: store.state.simulatorState.funding?.isChecked ?? false,
                                 nextPages: AnyView(SimulatorFunding0(shouldPopToRootView: self.$nextStep)))
                CustomDivider()
                SimulatorRowView(currentViewType: store.state.simulatorState.currentEvent,
                                 name: Constant.title_fee_charges_container,
                                 typeView: .eventFees,
                                 isChecked: store.state.simulatorState.fees?.isChecked ?? false,
                                 nextPages: AnyView(SimulatorFee0(shouldPopToRootView: self.$nextStep)))
                CustomDivider()
                SimulatorRowView(currentViewType: store.state.simulatorState.currentEvent,
                                 name: Constant.title_type_funding_container,
                                 typeView: .eventTax,
                                 isChecked: store.state.simulatorState.tax?.isChecked ?? false,
                                 nextPages: AnyView(SimulatorTax0(shouldPopToRootView: self.$nextStep)))
                Spacer()
            }
        }.background(Color.init("DefaultBackground").edgesIgnoringSafeArea(.all))
    }

    var body: some View {
        NavigationView {
            displayBody
                .navigationTitle(Text(Constant.title_back))
                .navigationBarHidden(true)
        }
    }
}
