//
//  HomeDetailView.swift
//  ios-rentor
//
//  Created by Thomas on 05/10/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct HomeDetailView: View {
    private let rentalSelected: RentorEntity
    
    init(with rental: RentorEntity) {
        self.rentalSelected = rental
    }
    
    var body: some View {
        Text("SELECTED = \(self.rentalSelected.name ?? "")")
    }
}

struct HomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailView(with: RentorEntity())
    }
}
