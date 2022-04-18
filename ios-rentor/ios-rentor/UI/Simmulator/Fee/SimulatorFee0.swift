//
//  SimulatorFee0.swift
//  ios-rentor
//
//  Created by Thomas on 10/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimulatorFee0: View {
    @EnvironmentObject private var store: AppStore
    @Binding var shouldPopToRootView: Bool
    @State private var text: String = ""
    @State private var opacity: Double = 1
    @State private var nextButton: Bool = false
    
    var handlePrices: some View {
        Group {
            PriceView(title: Constant.title_giving_part,
                      placeHolderTextField: Constant.place_holder_giving_part,
                      textfieldValue: $text,
                      opacity: $opacity)
            
            PriceView(title: Constant.title_price_funding,
                      placeHolderTextField: Constant.place_holder_price_funding,
                      textfieldValue: $text,
                      opacity: $opacity)
            
            PriceView(title: Constant.title_secure_funding,
                      placeHolderTextField: Constant.place_holder_secure_funding,
                      textfieldValue: $text,
                      opacity: $opacity)
            
            PriceView(title: Constant.title_rate_funding,
                      placeHolderTextField: Constant.place_holder_rate_funding,
                      textfieldValue: $text,
                      opacity: $opacity)
        }
    }
    
    var content: some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            TextTitle(title: Constant.title_fee_view)
            handlePrices
        }
    }

    var body: some View {
        SimulatorBackground(content: {
            content
        }, barTitle: nil)
            .navigationBarItems(trailing: Button(action: {
                let fee = SimulatorFee(isDone: true, isChecked: true)
                store.dispatch(.simulatorAction(action: .setFees(fees: fee)))
                store.dispatch(.simulatorAction(action: .fetchActivities))
                self.shouldPopToRootView = false
                
            }, label: {
                Text(Constant.save_and_quit)
            }).disabled(!($text.wrappedValue.count >= 3 ||
                          Int($text.wrappedValue) == 0)) )
    }
}
