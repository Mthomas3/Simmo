//
//  HomeListView.swift
//  ios-rentor
//
//  Created by Thomas on 17/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct HomeListView: View {
    
    public let onDelete: (IndexSet) -> Void
    
    private let navigationBarTitle: String = "Mes Simmulations"
    @EnvironmentObject private var store: AppStore
    @State private var showingAddForm = false
    @State private var showCancelButton: Bool = false
    @State private var searchText = ""
    @ObservedObject var searchBar: SearchBar = SearchBar()

    var body: some View {
        NavigationView {
            propertyList
                .navigationBarTitle(Text(self.navigationBarTitle))
                .navigationBarItems(trailing: addButton)
                .add(self.searchBar)
        }
    }
}

extension HomeListView {
    
    var propertyList: some View {
        Group {
            if store.state.homeState.homeRentors.count > 0 {
                List {
                    ForEach(store.state.homeState.homeRentors.filter { ($0.name ?? "")
                                .hasPrefix(searchText) || searchText == ""}) { property in
                        ZStack {
                            HomeRowView(rentor: property)
                                .padding(.top, 10)
                            
                            NavigationLink(destination: HomeDetailView(with: property)) {
                                EmptyView()
                                    .background(Color.gray)
                            }.frame(width: 0)
                            .opacity(0)
                            .buttonStyle(PlainButtonStyle())
                            .padding(.top, 10)
                        }.listRowInsets(EdgeInsets())
                        .padding(.all, 8)
                        .listRowBackground(Color.init("gray"))
                    }.onDelete(perform: onDelete)
                }.listStyle(PlainListStyle())
            } else {
                Text("Please add a property... \(store.state.homeState.homeRentors.count)")
            }
        }
    }
    
    var addButton: some View {
        Group {
            Button(action: {
                showingAddForm.toggle()
            }) {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .foregroundColor(Color.init("PrimaryViolet"))
            }.sheet(isPresented: $showingAddForm) {
                SimmulatorView($showingAddForm)
                    .environmentObject(store)
            }
        }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView(onDelete: {_ in })
    }
}
