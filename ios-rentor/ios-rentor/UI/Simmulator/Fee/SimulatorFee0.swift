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

    var body: some View {
        VStack {
            Text("SAVE FEE TRY")
        }.navigationBarItems(trailing: Button(action: {
            let fee = SimulatorFee(isDone: true, isChecked: true, name: "FEE DONE")
            store.dispatch(.simulatorAction(action: .setFees(fees: fee)))
            store.dispatch(.simulatorAction(action: .fetchActivities))
            self.shouldPopToRootView = false
        }, label: {
            Text("Enregistrer et quitter")
        }))
    }
}
