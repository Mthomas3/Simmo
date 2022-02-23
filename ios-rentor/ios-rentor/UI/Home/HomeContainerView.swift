//
//  HomeContainerView.swift
//  ios-rentor
//
//  Created by Thomas on 17/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct HomeContainerView: View {
    private let progressTitle: String = "Loading..."
        
    @EnvironmentObject var store: AppStore
    @EnvironmentObject var tabData: MainTabBarData
    
    var body: some View {
        HomeListView(onDelete: deleteProperty(at:))
    }
}

struct HomeContainerView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContainerView()
    }
}

extension HomeContainerView {
    func deleteProperty(at offsets: IndexSet) {
        if let first = offsets.first {
            store.dispatch(.homeAction(action: .delete(item: store.state.homeState.homeRentors[first])))
        }
    }
}
