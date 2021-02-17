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
    
    var body: some View {
        if store.state.homeState.fetchInProgress {
            ProgressView(self.progressTitle)
        } else {
            HomeListView(properties: store.state.homeState.current,
                         onDelete: deleteProperty(at:))
        }
    }
}

struct HomeContainerView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContainerView()
    }
}

extension HomeContainerView {
    func deleteProperty(at offsets: IndexSet) {
        for o in offsets {
            print("delete \(o)")
        }
    }
}
