//
//  SimmulatorView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct SimmulatorView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Create a new Simmulation view")
                Button(action: {
                    print("yo?")
                }) {
                    Text("Hello?")
                }
            }
            .navigationBarTitle(Text("Simmulator"))
        }
    }
}

struct SimmulatorView_Previews: PreviewProvider {
    static var previews: some View {
        SimmulatorView()
    }
}
