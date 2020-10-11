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
import MapKit

struct Home: View {
    //MARK: State
    @State private var dataSources: [RentorEntity] = []
    @State private var displayAlert: Bool = false
    @State private var messageAlert: String = ""
    @State private var headerList: String = ""
    
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
            }
        }
    }
    
    private func eventAddSimmulations() {
        
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    private func displayBackgroundImage(with name: String) -> some View {
        Image(name).resizable().edgesIgnoringSafeArea(.top).frame(height: 150)
    }
    @State var showingDetails = false
    private func navigationBarAdd() -> some View {
        Image(systemName: "plus")
            .imageScale(.large)
            .foregroundColor(Color.init("LightBlue"))
            .sheet(isPresented: $showingDetails) {
                SimmulatorView()
            }
    }
    
    private func headerListView() -> some View {
        Text(self.headerList.concat(string: "$US / month 💵"))
            .onReceive(self.output.headerListValue) { (value) in
                self.headerList = value
        }.foregroundColor(Color.init("LightBlue"))
        .font(.system(size: 16, weight: .bold))
    }
    
    private func body(with size: CGSize) -> some View {
        List {
            Section(header: self.headerListView()) {
                self.displayRentalProperties()
                    .listRowBackground(Color.clear)
            }
        }.font(Font.system(size: self.fontSize(for: size)))
        .navigationBarTitle(Text("Home 🏡"))
        .navigationBarItems(trailing: self.navigationBarAdd())
        .listStyle(GroupedListStyle())
        
    }
    
    private func displayRentalProperties() -> some View {
        ForEach(self.dataSources) { rentalProperty in
            ZStack {
                RentalContentView(with: rentalProperty)
                NavigationLink(destination: HomeDetailView(with: rentalProperty)) {
                    EmptyView()
                }.buttonStyle(PlainButtonStyle())
            }
        }.onDelete { indexSet in
            if let currentIndex = indexSet.first {
                self.onDelete.send(self.dataSources[currentIndex])
            }
        }
        .alert(isPresented: self.$displayAlert) {
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
