//
//  SimulatorFundingLoan.swift
//  ios-rentor
//
//  Created by Thomas on 15/02/2022.
//  Copyright © 2022 Thomas. All rights reserved.
//

import SwiftUI

struct SimulatorFundingLoan: View {
    @EnvironmentObject private var store: AppStore
    @Binding var shouldPopToRootView: Bool
    
    @State private var name: String = ""
    @State private var opacity: Double = 1
    
    var content: some View {
        HStack(alignment: .top, spacing: 0) {
            LazyVStack(alignment: .leading, spacing: 12) {
                TextTitle(title: Constant.title_is_your_building)
                    .padding(.bottom, 12)
                
                TextField(Constant.place_holder_price, text: $name)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.bottom, 8)
                
                PriceView(title: Constant.title_what_price,
                          placeHolderTextField: Constant.place_holder_price,
                          textfieldValue: $name,
                          opacity: $opacity)
                Spacer()
            }
            Spacer()
        }
    }
    
    var body: some View {
        SimulatorBackground(content: {
            content
        }, barTitle: nil).navigationBarItems(trailing: Button(action: {
                let funding = SimulatorFunding(isDone: true, isChecked: true, name: "done")
                store.dispatch(.simulatorAction(action: .setFunding(funding: funding)))
                store.dispatch(.simulatorAction(action: .fetchActivities))
                self.shouldPopToRootView = false
            }, label: {
                Text(Constant.save_and_quit)
            }).disabled(!($name.wrappedValue.count >= 3
                          || Int($name.wrappedValue) == 0)))
    }
}
