//
//  SimmulatorListView2.swift
//  ios-rentor
//
//  Created by Thomas on 26/07/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimulatorInformation0: View {
    
    @EnvironmentObject private var store: AppStore
    @Binding var shouldPopToRootView: Bool
    @State private var cardSelected: Int?
    @State private var isCurrentSelected: Int?
    @State private var nextButton: Bool = false
    @State private var nexStep: Bool = false
    
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextTitle(title: Constant.title_ask_kind_building)
            HStack {
                Spacer()
                CardView(eventSelected: self.$cardSelected,
                         index: 0, name: Constant.title_old_building, image: "Old")
                CardView(eventSelected: self.$cardSelected,
                         index: 1, name: Constant.title_new_building, image: "New")
                Spacer()
            }
            
            HStack {
                Spacer()
                CardView(eventSelected: self.$cardSelected,
                         index: 2, name: Constant.title_construct_area, image: "Construction")
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                CardView(eventSelected: self.$cardSelected,
                         index: 3, name: Constant.title_building_renovate, image: "Renovate")
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                Spacer()
            }
            
            TextSub(title: Constant.title_will_be_rented)
            
            HStack(alignment: .center) {
                Spacer()

                ButtonOption(eventButtonSelect: self.$isCurrentSelected,
                             nextButton: self.$nextButton, title: Constant.title_yes, index: 0)
                ButtonOption(eventButtonSelect: self.$isCurrentSelected,
                             nextButton: self.$nextButton, title: Constant.title_no, index: 1)
                Spacer()
            }
        }
    }
 
    var body: some View {
        SimulatorBackground(content: {
            content
        }, barTitle: "")
            .navigationBarTitle(Text(""), displayMode: .inline)
            .background(Color.init("BackgroundHome").edgesIgnoringSafeArea(.all))
            .overlay(
                OverlayView(isActive: $nexStep,
                            isHidden: !($nextButton.wrappedValue),
                            nextView: AnyView(SimulatorInformation1(shouldPopToRootView:
                                                                        self.$shouldPopToRootView)
                                                .environmentObject(store)),
                            nextTitle: Constant.title_next,
                            callback: {
                                let simulator = SimulatorInformation(type:
                                                                        SimulatorType(rawValue: self.cardSelected ?? 0),
                                                                     rented: (self.isCurrentSelected ?? 0) == 0,
                                                                     owner: nil,
                                                                     price: nil, name: nil, color: nil, image: nil)
                                self.store.dispatch(.simulatorAction(action: .setInformations(informations: simulator)))
                                self.nexStep.toggle()
                            }), alignment: .bottomTrailing
            )
    }
}
