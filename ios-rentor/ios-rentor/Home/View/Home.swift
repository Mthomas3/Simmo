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
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("To do's")) {
                    ForEach(self.fetchRentalProperties) { item in
                        RentalEntityView(title: item.name!, createDate: "\(item.createDate!)")
                    }.onDelete { indexSet in
                        
                        if let currentIndex = indexSet.first {
                            do {
                                try CoreDataManager.sharedInstance.deleteRental(with: self.fetchRentalProperties[currentIndex])
                            } catch {
                                print(error)
                            }
                        }
                    }
                }.font(.headline)
                
            }.background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.top))
            .navigationBarTitle(Text("Simmulations"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct DisplaySimulations_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
