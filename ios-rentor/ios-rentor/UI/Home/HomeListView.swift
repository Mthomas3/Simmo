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
    
    var body: some View {
        NavigationView {
             ZStack {
                Color.black.opacity(0.05).edgesIgnoringSafeArea(.all)
                propertyImproved
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
    
    var propertyImproved: some View {
        Group {
            if properties.count > 0 {
                List {
                    ForEach(properties) { property in
                        ZStack {
                            HomeRowView(rentor: property)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                                .listRowInsets(EdgeInsets())
                            
                            NavigationLink(destination: HomeDetailView(with: property)) {
                                EmptyView()
                            }.frame(width: 0)
                            .opacity(0)
                            
                        }.listRowBackground(Color.clear)
                    }.onDelete(perform: onDelete)
                }.listStyle(PlainListStyle())
            } else {
                Text("No properties \(properties.count)")
            }
        }
    }
    
    var propertyList: some View {
        Group {
            if properties.count > 0 {
                List {
                    ForEach(store.state.homeState.homeRentors) { property in
                        //HomeRowView(rentor: property)
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
                        .background(Color.pink)
                        .listRowBackground(Color.green)
                    }.onDelete(perform: onDelete)
                }.listStyle(PlainListStyle())
                .background(Color.gray)
            } else {
                Text("Nothing inside")
            }
        }.background(Color.green)
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
