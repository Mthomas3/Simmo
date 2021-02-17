//
//  HomeListView.swift
//  ios-rentor
//
//  Created by Thomas on 17/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {
    let color1 = Color(red: 0.235, green: 0.267, blue: 0.318)
    let color2 = Color(red: 0.07, green: 0.078, blue: 0.092)
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [color1, color2]),
                       startPoint: .top,
                       endPoint: .bottom).edgesIgnoringSafeArea(.all)
    }
}

struct HomeListView: View {
    
    private let navigationBarTitle: String = "Home"
    
    public var properties: [Rentor]
    public let onDelete: (IndexSet) -> Void
    
    var body: some View {
        ZStack {
            BackgroundView()
            NavigationView {
                propertyList
                    .navigationBarTitle(Text(self.navigationBarTitle))
            }
        }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView(properties: [], onDelete: {_ in })
    }
}


extension HomeListView {
    var propertyList: some View {
        Group {
            if (properties.count > 0) {
                Text("Something inside bro \(properties[0].name ?? "")")
            } else {
                Text("Nothing inside")
            }
        }
    }
}
