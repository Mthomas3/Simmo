//
//  SettingContainerView.swift
//  ios-rentor
//
//  Created by Thomas on 10/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SettingContainerView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        SettingListView()
            .environmentObject(store)
    }
}

struct SettingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SettingContainerView()
    }
}
