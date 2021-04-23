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
            /*VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("search", text: $searchText, onEditingChanged: { _ in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(.primary)

                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }.padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    if showCancelButton {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true)
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }.padding(.horizontal)
                .navigationBarHidden(showCancelButton)
//
//                propertyList
//                    .navigationBarTitle(Text(self.navigationBarTitle))
//                    .navigationBarItems(trailing: addButton)


                List {
                    
                    ForEach(store.state.homeState.homeRentors.filter { ($0.name ?? "").hasPrefix(searchText) || searchText == ""}) {
                        searchText in Text(searchText.name ?? "")
                    }
                    /*ForEach(store.state.homeState.homeRentors.filter{ $0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                        searchText in Text(searchText)
                    }*/
                }
                .navigationBarTitle(Text("Search"))
                .resignKeyboardOnDragGesture()
            }
         }*/propertyList
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
                        /*ZStack {
                            HomeRowView(rentor: property)
                                .padding(.top, 10)
                                .background(Color.pink)
                            
                            NavigationLink(destination: HomeDetailView(with: property)) {
                                EmptyView()
                                    .background(Color.gray)
                            }.frame(width: 0)
                            .opacity(0)
                            //.buttonStyle(PlainButtonStyle())
                            .padding(.top, 10)
                            .background(Color.black)
                            
                        }.listRowInsets(EdgeInsets())
                        .padding(.all, 8)
                        .listRowBackground(Color.init("TableViewGray"))
                        .background(Color.green)*/
                        
                        //HomeRowView(rentor: property)
                        StoreRow(title: property.name ?? "", address: "MDR?", city: "TOTO", categories: ["NOTHING"], kilometres: 30)
                        
                    }.onDelete(perform: onDelete)
                }
                /*List {
                    ForEach(store.state.homeState.homeRentors.filter { ($0.name ?? "")
                                .hasPrefix(searchText) || searchText == ""}) { property in
                        /*ZStack {
                            HomeRowView(rentor: property)
                                .padding(.top, 10)
                                .background(Color.pink)
                            
                            NavigationLink(destination: HomeDetailView(with: property)) {
                                EmptyView()
                                    .background(Color.gray)
                            }.frame(width: 0)
                            .opacity(0)
                            //.buttonStyle(PlainButtonStyle())
                            .padding(.top, 10)
                            .background(Color.black)
                            
                        }.listRowInsets(EdgeInsets())
                        .padding(.all, 8)
                        .listRowBackground(Color.init("TableViewGray"))
                        .background(Color.green)*/
                        
                        //HomeRowView(rentor: property)
                        StoreRow(title: property.name ?? "", address: "MDR?", city: "TOTO", categories: ["NOTHING"], kilometres: 30)
                            .listRowBackground(Color.black)
                    }.onDelete(perform: onDelete)
                }.resignKeyboardOnDragGesture()*/
            } else {
                Text("Please add a property... \(store.state.homeState.homeRentors.count)")
            }
        }.padding(.all, -20)
        
    }
    
    var addButton: some View {
        Group {
            Button(action: {
                //showingAddForm.toggle()
                store.dispatch(.settingsAction(action: .setHasLaunchedApp(status: false)))
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

struct StoreRow: View {
    
    var title: String
    var address: String
    var city: String
    var categories: [String]
    var kilometres: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Color.yellow
            HStack {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.red, .blue]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    VStack {
                        Text("\(kilometres)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("km")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 70, height: 70, alignment: .center)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .padding(.bottom, 5)
                    
                    Text(address)
                        .padding(.bottom, 5)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "mappin")
                        Text(city)
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            //CategoryPill(categoryName: category)
                        }
                    }
                    
                }
                .padding(.horizontal, 5)
            }
            .padding(15)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
