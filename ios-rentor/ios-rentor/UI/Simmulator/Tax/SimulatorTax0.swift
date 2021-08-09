//
//  SimulatorTax0.swift
//  ios-rentor
//
//  Created by Thomas on 10/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimulatorTax0: View {
    @EnvironmentObject private var store: AppStore
    @Binding var shouldPopToRootView: Bool

    var body: some View {
        VStack {
            Text("SAVE TAX TRY")
        }.navigationBarItems(trailing: Button(action: {
            let tax = SimulatorTax(isDone: true, isChecked: true, name: "TAX DONE")
            store.dispatch(.simulatorAction(action: .setTax(tax: tax)))
            store.dispatch(.simulatorAction(action: .fetchActivities))
            self.shouldPopToRootView = false
        }, label: {
            Text("Enregistrer et quitter")
        }))
    }
}
