//
//  SimmulatorContainer.swift
//  ios-rentor
//
//  Created by Thomas on 22/06/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimmulatorContainer: View {
    @EnvironmentObject internal var modalView: MainTabBarData
    @EnvironmentObject internal var store: AppStore
    
    var body: some View {
        SimmulatorListView()
    }
}
