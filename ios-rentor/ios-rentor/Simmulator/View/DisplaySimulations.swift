//
//  DisplaySimulations.swift
//  ios-rentor
//
//  Created by Thomas on 30/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI
import CoreData

struct DisplaySimulations: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: RentorEntity.getAllRentorEntities()) var simmulationsData: FetchedResults<RentorEntity>
    
    @State private var newRentalName = ""
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Rental Adding")) {
                    HStack {
                        TextField("new Item", text: self.$newRentalName)
                        Button(action: {
                            let rentalItem = RentorEntity(context: self.managedObjectContext)
                            rentalItem.name = self.newRentalName
                            rentalItem.createDate = Date()
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            
                            self.newRentalName = ""
                            
                        }) {
                            Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                            .imageScale(.large)
                        }
                    }.font(.headline)
                }
                
                
                Section(header: Text("To do's")) {
                    ForEach(self.simmulationsData) { item in
                        RentalEntityView(title: item.name!, createDate: "\(item.createDate!)")
                    }.onDelete { indexSet in
                        let deleteItem = self.simmulationsData[indexSet.first!]
                        self.managedObjectContext.delete(deleteItem)
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
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
        DisplaySimulations()
    }
}
