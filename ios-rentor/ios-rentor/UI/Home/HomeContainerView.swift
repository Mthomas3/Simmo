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
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        HomeListView(properties: store.state.homeState.homeRentors,
                     onDelete: deleteProperty(at:))
            .environmentObject(store)
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
            print("[we should delete this = \(store.state.homeState.homeRentors[first])]")
        }
    }
}
