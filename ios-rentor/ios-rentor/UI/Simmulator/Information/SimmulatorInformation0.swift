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
    @State private var cardSelected: CardItemType?
    @State private var isCurrentSelected: ButtonEventType?
    @State private var nextButton: Bool = false
    @State private var nexStep: Bool = false
    
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextTitle(title: Constant.title_ask_kind_building)
            
            CardView(cardItem: $cardSelected,
                     first_index: 0,
                     second_index: 1,
                     first_name: Constant.title_old_building,
                     second_name: Constant.title_new_building,
                     first_picture: "Old",
                     second_picture: "New")
            
            CardView(cardItem: $cardSelected,
                     first_index: 2,
                     second_index: 3,
                     first_name: Constant.title_construct_area,
                     second_name: Constant.title_building_renovate,
                     first_picture: "Construction",
                     second_picture: "Renovate")

            TextSub(title: Constant.title_will_be_rented)
                        
            AskButtonView(value: $isCurrentSelected,
                          nextButton: $nextButton,
                          first_title: Constant.title_yes,
                          second_title: Constant.title_no)
        }
    }
 
    var body: some View {
        SimulatorBackground(content: {
            content
        }, barTitle: Constant.title_empty)
            .navigationBarTitle(Text(Constant.title_empty), displayMode: .inline)
            .background(Color.init("BackgroundHome").edgesIgnoringSafeArea(.all))
            .overlay(
                OverlayView(isActive: $nexStep,
                            isHidden: !($nextButton.wrappedValue),
                            nextView: AnyView(SimulatorInformation1(shouldPopToRootView:
                                                                        self.$shouldPopToRootView)
                                                .environmentObject(store)),
                            nextTitle: Constant.title_next,
                            callback: {
                                let simulator =
                                SimulatorInformation(type: SimulatorType(rawValue: cardSelected?.rawValue ?? 0),
                                                                     rented: (isCurrentSelected?.rawValue ?? 0) == 0,
                                                                     owner: nil,
                                                                     price: nil, name: nil, color: nil, image: nil)
                                self.store.dispatch(.simulatorAction(action: .setInformations(informations: simulator)))
                                self.nexStep.toggle()
                            }), alignment: .bottomTrailing
            )
    }
}
