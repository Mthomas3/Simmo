//
//  SimulatorFee01.swift
//  ios-rentor
//
//  Created by Thomas on 18/02/2022.
//  Copyright © 2022 Thomas. All rights reserved.
//

import SwiftUI

struct SimulatorFee01: View {
    @EnvironmentObject private var store: AppStore
    @Binding var shouldPopToRootView: Bool
    @State private var name: String = ""
    @State private var opacity: Double = 1
    @State private var nextButton: Bool = false
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.init("BackgroundHome")
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
        }.navigationBarTitle(Text(""), displayMode: .inline)
            .background(Color.init("BackgroundHome").edgesIgnoringSafeArea(.all))
        .navigationBarItems(trailing: Button(action: {
            let fee = SimulatorFee(isDone: true, isChecked: true, name: "FEE DONE")
            store.dispatch(.simulatorAction(action: .setFees(fees: fee)))
            store.dispatch(.simulatorAction(action: .fetchActivities))
            self.shouldPopToRootView = false
        }, label: {
            Text("Enregistrer et quitter")
        }))
    }
}
