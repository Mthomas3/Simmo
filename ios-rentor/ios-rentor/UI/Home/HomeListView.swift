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
        }
    }
}

extension HomeListView {
    
    var propertyList: some View {
        Group {
            if store.state.homeState.homeRentors.count > 0 {
                VStack(spacing: 0) {
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
                    .background(Color.blue)
                    List {
                        ForEach(store.state.homeState.homeRentors.filter { ($0.name ?? "")
                                    .hasPrefix(searchText) || searchText == ""}) { property in
                            ZStack {
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
                            .background(Color.green)
                            
                        }.onDelete(perform: onDelete)
                    }.listStyle(GroupedListStyle())
                    .resignKeyboardOnDragGesture()
                    .padding(.top, 10)
                    .background(Color.yellow)
                }.background(Color.red)
            } else {
                Text("Please add a property... \(store.state.homeState.homeRentors.count)")
            }
        }
    }
    
    var addButton: some View {
        Group {
            Button(action: { showingAddForm.toggle() }) {
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

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
