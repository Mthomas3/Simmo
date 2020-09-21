//
//  DisplaySimulations.swift
//  ios-rentor
//
//  Created by Thomas on 30/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI
import CoreData

struct Home: View {
    @State public var shouldDisplayError: Bool = false
    @ObservedObject private var homeViewModel = HomeViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.black.withAlphaComponent(0.05)
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
    var body: some View {
        let a = Binding<Bool>.constant(self.homeViewModel.shouldDisplayError.value)
        
        return NavigationView {
            List {
                ForEach(self.homeViewModel.dataSources) { rentalProperty in
                    RentalEntityView(rentor: rentalProperty)
                }.onDelete { indexSet in
                    if let currentIndex = indexSet.first {
                        self.homeViewModel.deleteRentals(with: currentIndex)
                    }
                }.alert(isPresented: a) {
                    Alert(title: Text("An error occured"),
                          message: Text("Unable to fetch the necessary data. Please try again"))
                }
            }.navigationBarTitle(Text("Home"), displayMode: .automatic)
            .navigationBarItems(trailing: EditButton())
            .listStyle(GroupedListStyle())
            .onAppear {
                
            }
        }
    }
}

struct DisplaySimulations_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
