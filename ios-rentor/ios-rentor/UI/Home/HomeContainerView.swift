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
        HomeListView(onDelete: deleteProperty(at:))
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
            store.dispatch(.action(action: .delete(item: store.state.homeState.homeRentors[first])))
        }
    }
}

struct BackgroundView: View {
    
    let color1 = Color(red: 0.235, green: 0.267, blue: 0.318)
    let color2 = Color(red: 0.07, green: 0.078, blue: 0.092)
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [color1, color2]),
                       startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
    }
}
