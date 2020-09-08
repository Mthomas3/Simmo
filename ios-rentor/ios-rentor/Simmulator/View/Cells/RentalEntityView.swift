//
//  RentalEntityView.swift
//  ios-rentor
//
//  Created by Thomas on 04/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct RentalEntityView: View {
    var title: String = ""
    var createDate: String = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(createDate)
                    .font(.caption)
            }
        }
    }
}

struct RentalEntityView_Previews: PreviewProvider {
    static var previews: some View {
        RentalEntityView()
    }
}
