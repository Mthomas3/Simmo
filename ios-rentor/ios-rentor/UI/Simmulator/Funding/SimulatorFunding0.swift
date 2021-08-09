//
//  SimulatorFunding0.swift
//  ios-rentor
//
//  Created by Thomas on 10/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimulatorFunding0: View {
    @EnvironmentObject private var store: AppStore
    @Binding var shouldPopToRootView: Bool

    var body: some View {
        VStack {
            Text("HELLO WORLD")
        }.navigationBarItems(trailing: Button(action: {
            let funding = SimulatorFunding(isDone: true, isChecked: true, name: "FUNDING DONE")
            store.dispatch(.simulatorAction(action: .setFunding(funding: funding)))
            store.dispatch(.simulatorAction(action: .fetchActivities))
            self.shouldPopToRootView = false
        }, label: {
            Text("Enregistrer et quitter")
        }))
    }
}
