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
    @State private var name: String = ""
    @State private var opacity: Double = 1
    @State private var nextButton: Bool = false
    
    var content: some View {
        LazyVStack(alignment: .leading, spacing: 30) {
            TextTitle(title: "Quels sont les frais annuels non récupérables?")
            PriceView(title: "Charge de copropriété: ",
                      placeHolderTextField: "1 200 000€",
                      textfieldValue: $name,
                      opacity: self.$opacity)
            
            PriceView(title: "Taxe foncière: ",
                      placeHolderTextField: "1 200 000€",
                      textfieldValue: $name,
                      opacity: self.$opacity)
            
            PriceView(title: "Assurance PNO: ",
                      placeHolderTextField: "1 200 000€",
                      textfieldValue: $name,
                      opacity: self.$opacity)
            
            PriceView(title: "Assurance loyers impayés: ",
                      placeHolderTextField: "1 200 000€",
                      textfieldValue: $name,
                      opacity: self.$opacity)
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
            }))
    }
}
