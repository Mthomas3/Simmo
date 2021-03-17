//
//  HomeListView.swift
//  ios-rentor
//
//  Created by Thomas on 17/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct HomeListView: View {
    
    private let navigationBarTitle: String = "Home 🏡"
    @EnvironmentObject private var store: AppStore
    
    public var properties: [Rentor]
    public let onDelete: (IndexSet) -> Void
    
    @State var showingAddForm = false
    
    init(properties: [Rentor], onDelete: @escaping (IndexSet) -> Void) {
        self.properties = properties
        self.onDelete = onDelete
        //UITableView.appearance().backgroundColor = UIColor.purple
    }
    
    var body: some View {
        NavigationView {
             ZStack {
                BackgroundView()
                propertyList
             }.navigationBarTitle(Text(self.navigationBarTitle))
             .navigationBarItems(trailing: addButton)
         }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView(properties: [], onDelete: {_ in })
    }
}

extension HomeListView {
    
    var headerView: some View {
        Text("1000$US / month 💵")
    }
    
    var propertyList: some View {
        Group {
            if properties.count > 0 {
                List {
                    Section(header: self.headerView) {
                        ForEach(self.properties) { property in
                            ZStack {
                                HomeRowView(rentor: property)
                                NavigationLink(destination: HomeDetailView(with: property)) {
                                    EmptyView()
                                }.frame(width: 0)
                                .opacity(0)
                                .buttonStyle(PlainButtonStyle())
                            }.listRowInsets(EdgeInsets())
                            .padding(.all, 8)
                            .listRowBackground(Color.black.opacity(0.05))
                        }.onDelete(perform: onDelete)
                    }
                }.listStyle(GroupedListStyle())
                
            } else {
                Text("Nothing inside")
            }
        }
    }
    
    var testButton: some View {
        Group {
            Button(action: {
                    store.dispatch(.action(action: .fetch))
                print("current = \(store.state.homeState.homeRentors.count)")
            }) {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .foregroundColor(Color.init("LightBlue"))
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
                    .environmentObject(store)
            }
        }
    }
}
