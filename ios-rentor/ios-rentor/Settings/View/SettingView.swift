//
//  SettingView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView {
            Text("Setting View")
            .navigationBarTitle(Text("Settings"))
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
