//
//  DisplaySimulations.swift
//  ios-rentor
//
//  Created by Thomas on 30/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

struct Home: View {
    //MARK: State
    @State private var dataSources: [RentorEntity] = []
    @State private var displayAlert: Bool = false
    @State private var messageAlert: String = ""
    
    //MARK: ViewModel
    private let homeViewModel: HomeViewModel
    private let output: HomeViewModel.Output
    private let onDelete: PassthroughSubject<RentorEntity, Never>
    
    //MARK: Drawing Constants
    private let navigationBarTitle: String = "Home"
    private let alertErrorTitle: String = "An error occured"
    private let fontScaleFactor: CGFloat = 0.04
    
    init() {
        
        self.onDelete = PassthroughSubject<RentorEntity, Never>()
        self.homeViewModel = HomeViewModel()
        self.output = self.homeViewModel.transform(
            HomeViewModel.Input(onDeleteSource: self.onDelete.eraseToAnyPublisher()))
        
        UITableView.appearance().backgroundColor = UIColor.black.withAlphaComponent(0.05)
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                self.body(with: geometry.size)
            }.navigationBarTitle(Text(self.navigationBarTitle))
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    private func body(with size: CGSize) -> some View {
        List {
            self.displayRentalProperties()
                .listRowBackground(Color.black.opacity(0.05))
        }.listStyle(PlainListStyle())
        .font(Font.system(size: self.fontSize(for: size)))
    }
    
    private func displayRentalProperties() -> some View {
        ForEach(self.dataSources) { rentalProperty in
            RentalContentView(with: rentalProperty)
        }.onDelete { indexSet in
            if let currentIndex = indexSet.first {
                self.onDelete.send(self.dataSources[currentIndex])
            }
        }.alert(isPresented: self.$displayAlert) {
            Alert(title: Text(self.alertErrorTitle),
                  message: Text(self.messageAlert),
                  primaryButton: .cancel(), secondaryButton: .destructive(Text("Retry")))
        }.onReceive(self.output.shouldDisplayError) { shouldDisplayValue in
            self.displayAlert = shouldDisplayValue
        }.onReceive(self.output.messageError) { messageValue in
            self.messageAlert = messageValue
        }.onReceive(self.output.dataSources) { dataSources in
            self.dataSources = dataSources
        }
    }
}

struct DisplaySimulations_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
