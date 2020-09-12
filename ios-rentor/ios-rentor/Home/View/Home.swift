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
    @FetchRequest(fetchRequest: CoreDataManager.sharedInstance.fetchRental())
        private var fetchRentalProperties: FetchedResults<RentorEntity>
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.black.withAlphaComponent(0.05)
        UITableViewCell.appearance().backgroundColor = UIColor.clear
        
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.fetchRentalProperties) { rentalProperty in
                    RentalEntityView(rentor: rentalProperty)
                }.onDelete { indexSet in
                    
                }
            }.navigationBarTitle(Text("Home"), displayMode: .automatic)
            .navigationBarItems(trailing: EditButton())
            .listStyle(GroupedListStyle())
            
             //.frame(maxWidth: .infinity, alignment: .center)
                
//                Section {
//                    ForEach(self.fetchRentalProperties) { item in
//                        RentalEntityView(title: item.name!, createDate: "\(item.createDate!)")
//                    }.onDelete { indexSet in
//                        if let currentIndex = indexSet.first {
//                            do {
//                                try CoreDataManager.sharedInstance.deleteRental(with: self.fetchRentalProperties[currentIndex])
//                            } catch {
//                                print(error)
//                            }
//                        }
//                    }
//                }.font(.headline)
//
            }
        }
    
}

struct DisplaySimulations_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
