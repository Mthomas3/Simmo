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
    @State private var text: String = ""
    @State private var opacity: Double = 1
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.init("BackgroundHome")
                LazyVStack(alignment: .leading, spacing: 30) {
                    TextTitle(title: "Financement partie 2: ")
                    PriceView(title: "Garantie de prêt: ",
                              placeHolderTextField: "Ex: 12000€",
                              textfieldValue: $text,
                              opacity: self.$opacity)
                    
                    PriceView(title: "Taux prêt: ",
                              placeHolderTextField: "Ex: 12000€",
                              textfieldValue: $text,
                              opacity: self.$opacity)
                }
            }
        }.navigationBarTitle(Text(""), displayMode: .inline)
            .background(Color.init("BackgroundHome").edgesIgnoringSafeArea(.all))
            .navigationBarItems(trailing: Button(action: {
                let funding = SimulatorFunding(isDone: true, isChecked: true, name: "FUNDING DONE")
                store.dispatch(.simulatorAction(action: .setFunding(funding: funding)))
                store.dispatch(.simulatorAction(action: .fetchActivities))
                self.shouldPopToRootView = false
            }, label: {
                Text("Enregistrer et quitter")
            }))
    }
}
