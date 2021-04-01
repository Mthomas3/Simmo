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
    
    public let onDelete: (IndexSet) -> Void
    
    @State private var showingAddForm = false
    
    var body: some View {
        NavigationView {
            propertyList
                .navigationBarTitle(Text(self.navigationBarTitle))
                .navigationBarItems(trailing: HStack { addButton
                    testButton
                })
         }
    }
}

extension HomeListView {
    
    var headerView: some View {
        Text("\(store.state.homeState.headerTitle)$US / month 💵")
    }
    
    var propertyList: some View {
        Group {
            if store.state.homeState.homeRentors.count > 0 {
                List {
                    Section(header: self.headerView) {
                        ForEach(store.state.homeState.homeRentors) { property in
                            ZStack {
                                HomeRowView(rentor: property)
                                NavigationLink(destination: HomeDetailView(with: property)) {
                                    EmptyView()
                                }.frame(width: 0)
                                .opacity(0)
                                .buttonStyle(PlainButtonStyle())
                            }.listRowInsets(EdgeInsets())
                            .padding(.all, 8)
                            .listRowBackground(Color.init("TableViewGray"))
                        }.onDelete(perform: onDelete)
                    }
                }.listStyle(GroupedListStyle())
                
            } else {
                Text("Please add a property... \(store.state.homeState.homeRentors.count)")
            }
        }
    }
    
    var testButton: some View {
        Group {
            Button(action: {
                print("do something crazy ")
                store.dispatch(.homeAction(action: .fetch))
            }) {
                Text("|¢|")
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

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView(onDelete: {_ in })
    }
}
