//
//  HomeDetailView.swift
//  ios-rentor
//
//  Created by Thomas on 05/10/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct HomeDetailView: View {
    // MARK: State
    private let rentalSelected: Rentor
    
    // MARK: ViewModel
    private let homeDetailViewModel: HomeDetailViewModel
    private let output: HomeDetailViewModel.Output?
    
    // MARK: Drawing Constants
    private let navigationBarTitle: String = "House Detail"
    private let fontScaleFactor: CGFloat = 0.04
    
    init(with rental: Rentor) {
        self.rentalSelected = rental
        
        self.homeDetailViewModel = HomeDetailViewModel()
        self.output = self.homeDetailViewModel.transform(HomeDetailViewModel.Input())
    }

    private func navigationBarAdd() -> some View {
        Button(action: {
            print("export action needed")
        }) {
            Text("Version PDF")
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(with: geometry.size)
        }.navigationBarTitle(Text(self.navigationBarTitle),
                             displayMode: .inline)
        .navigationBarItems(trailing: self.navigationBarAdd())
    }

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    private func displayHeader() -> some View {
        Section(header: Text("Editions")) {
            
        }
    }
    
    private func body(with size: CGSize) -> some View {
        VStack {
            List {
                self.displayHeader()
            }.font(Font.system(size: self.fontSize(for: size)))
            .listStyle(GroupedListStyle())
        }
    }
}

struct HomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailView(with: Rentor(date: Date(), name: "TEST A", price: 250000, rentPrice: 2500, cashFlow: 250, percentage: 25))
    }
}
