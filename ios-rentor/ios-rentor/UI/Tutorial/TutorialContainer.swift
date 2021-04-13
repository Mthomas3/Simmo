//
//  TutorialContainer.swift
//  ios-rentor
//
//  Created by Thomas on 03/04/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct TutorialContainer: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        VStack {
            Text("Tutorial web view")
            Button {
                store.dispatch(.settingsAction(action: .setHasLaunchedApp(status: true)))
                store.dispatch(.settingsAction(action: .fetch))
                print("DO SOMETHING")
            } label: {
                Text("DO CRAZY!")
            }

        }
    }
}

struct TutorialContainer_Previews: PreviewProvider {
    static var previews: some View {
        TutorialContainer()
    }
}
