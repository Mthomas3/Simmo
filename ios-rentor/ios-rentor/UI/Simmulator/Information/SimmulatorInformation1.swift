//
//  SimmulatorListView3.swift
//  ios-rentor
//
//  Created by Thomas on 03/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimulatorInformation1: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject private var store: AppStore
    @Binding var shouldPopToRootView: Bool
    
    @State internal var isCurrentSelected: Int?
    @State internal var nextButton: Bool = false
    @State private var opacity: Double = 1
    @State private var nextStep: Bool = false
    @State internal var name: String = ""
    
    var content: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                TextTitle(title: Constant.title_is_your_building)
                    .padding(.bottom, 8)
                HStack(alignment: .center) {
                    Spacer()
                    ButtonOption(eventButtonSelect: self.$isCurrentSelected,
                                 nextButton: self.$nextButton, title: Constant.title_yes, index: 0)
                    ButtonOption(eventButtonSelect: self.$isCurrentSelected,
                                 nextButton: self.$nextButton, title: Constant.title_no, index: 1)
                    Spacer()
                }.padding(.bottom, 12)

                PriceView(title: Constant.title_what_price,
                          placeHolderTextField: Constant.place_holder_price,
                          textfieldValue: $name,
                          opacity: self.$opacity)
                Spacer()
            }
            Spacer()
        }
    }
    
    var body: some View {
        SimulatorBackground(content: {
            content
        }, barTitle: nil)
            .overlay(
                OverlayView(isActive: $nextStep,
                            isHidden: !($name.wrappedValue.count > 3),
                            nextView: AnyView(SimulatorInformation2(shouldPopToRootView: self.$shouldPopToRootView)),
                            nextTitle: Constant.title_next,
                            callback: {
                                if var simulator = store.state.simulatorState.informations {
                                    simulator.owner = (self.isCurrentSelected ?? 0) == 0
                                    if (self.isCurrentSelected ?? 0) == 0 {
                                        simulator.price = Double(name)
                                    }
                                    self.store.dispatch(
                                        .simulatorAction(action: .setInformations(informations: simulator)))
                                }
                                self.nextStep.toggle()
                            }), alignment: .bottomTrailing)
    }
}
