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
    
    private let navigationBarTitle: String = "Home 🏡"
    
    public var properties: [Rentor]
    public let onDelete: (IndexSet) -> Void
    
    @State var showingAddForm = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            NavigationView {
                propertyList
                    .navigationBarTitle(Text(self.navigationBarTitle))
                    .navigationBarItems(trailing: addButton)
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
            if properties.count > 0 {
                List {
                    ForEach(properties) { property in
                        ZStack {
                            HomeRowView(rentor: property)
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets())
                            
                            NavigationLink(destination: HomeDetailView(with: property)) {
                                EmptyView()
                            }.frame(width: 0)
                            .opacity(0)
                            .buttonStyle(PlainButtonStyle())
                            .background(Color.red)
                            
                        }.listRowBackground(Color.clear)
                    }.onDelete(perform: onDelete)
                }.listStyle(PlainListStyle())
            } else {
                Text("Nothing inside")
            }
        }
    }
    
    var addButton: some View {
        Group {
            Button(action: { showingAddForm.toggle() }) {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
                    .foregroundColor(Color.init("LightBlue"))
            }.sheet(isPresented: $showingAddForm) {
                SimmulatorView($showingAddForm)
            }
        }
    }
}
