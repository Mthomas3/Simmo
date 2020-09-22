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
    @ObservedObject private var homeViewModel = HomeViewModel()
    
    //MARK: Drawing Constants
    private let navigationBarTitle: String = "Home"
    private let alertErrorTitle: String = "An error occured"
    private let fontScaleFactor: CGFloat = 0.04
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.black.withAlphaComponent(0.05)
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                self.body(with: geometry.size)
            }
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    private func body(with size: CGSize) -> some View {
        List {
            self.displayRentalProperties()
        }.navigationBarTitle(Text(self.navigationBarTitle), displayMode: .automatic)
        .navigationBarItems(trailing: EditButton())
        .listStyle(GroupedListStyle())
            .font(Font.system(size: self.fontSize(for: size)))
    }
    
    private func displayRentalProperties() -> some View {
        ForEach(self.homeViewModel.dataSources) { rentalProperty in
            RentalContentView(with: rentalProperty)
        }.onDelete { indexSet in
            if let currentIndex = indexSet.first {
                self.homeViewModel.deleteRentals(with: currentIndex)
            }
        }.alert(isPresented: Binding<Bool>.constant(self.homeViewModel.shouldDisplayError.value)) {
            Alert(title: Text(self.alertErrorTitle), message: Text(self.homeViewModel.messageDisplayError.value))
        }
    }
}

struct DisplaySimulations_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
