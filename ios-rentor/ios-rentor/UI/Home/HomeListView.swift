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
            ZStack {
                
                propertyList
                    .navigationBarTitle(Text(self.navigationBarTitle))
                    //.navigationBarItems(trailing: addButton)
                    //.add(self.searchBar)
            }
            
        }
    }
}

extension HomeListView {
    
    private func renderOnBoardingHome() -> some View {
        VStack(alignment: .center) {
            Image("onBoardingHomeAdding")
            Text("Aucune simulation")
                .foregroundColor(Color.init("DarkGray"))
                .font(.system(size: 24))
            Text("Appueyez sur + pour simuler un investissement immobilier")
                .foregroundColor(Color.init("LightGray"))
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                .padding(.top, 4)
                .padding(.leading, 16)
                .padding(.trailing, 16)
        }.padding(.leading, 16)
        .padding(.trailing, 16)
        .onTapGesture {
            SimmulatorContainer()
        }
    }
    
    var propertyList: some View {
        Group {
            if store.state.homeState.homeRentors.count > 0 {
                ZStack {
                    Color.init("BackgroundHome").edgesIgnoringSafeArea(.all)
                    List {
                        ForEach(store.state.homeState.homeRentors.filter { searchBar.text.isEmpty ||
                                    ($0.name ?? "").lowercased().contains(searchBar.text.lowercased()) }) { property in
                            ZStack {
                                HomeRowView(rentor: property)
                                    .padding(.top, 10)
                                    .padding(.leading, 8)
                                    .padding(.trailing, 8)
                                    .shadow(color: Color.init("ShadowHomeCell").opacity(1), radius: 5, x: 2, y: 2)
                                    .background(Color.clear)
                                NavigationLink(destination: HomeDetailView(with: property)) {
                                    EmptyView()
                                }.frame(width: 0)
                                .opacity(0)
                                .buttonStyle(PlainButtonStyle())
                                .padding(.top, 10)
                            }.listRowInsets(EdgeInsets())
                            .padding(.all, 8)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                            .background(Color.init("BackgroundHomeListCell"))
                        }.onDelete(perform: onDelete)
                    }.listStyle(PlainListStyle())
                }
                //.add(self.searchBar)
            } else {
                ZStack {
                    Color.init("BackgroundHome").edgesIgnoringSafeArea(.all)
                    self.renderOnBoardingHome()

                }
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
                SimmulatorView()
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
