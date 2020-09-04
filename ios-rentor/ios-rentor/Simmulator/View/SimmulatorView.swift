//
//  SimmulatorView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct SimmulatorView: View {
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @State private var newRentalName: String = ""
    
    var body: some View {
        NavigationView {
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
                }
                .font(.headline)
                .navigationBarTitle(Text("Simmulator"))
                .padding(.leading, 10)
                .padding(.trailing, 10)
        }
    }
}

struct SimmulatorView_Previews: PreviewProvider {
    static var previews: some View {
        SimmulatorView()
    }
}
