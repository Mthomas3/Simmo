//
//  AlertView.swift
//  ios-rentor
//
//  Created by Thomas on 12/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct AlertView: View {
    @State private var showingAlert = false
    
    var body: some View {
        Button("Show Alert") {
            self.showingAlert = true
        }.alert(isPresented: self.$showingAlert) {
            Alert(title: Text("Hello?"), message: Text(""))
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
