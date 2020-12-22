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
    // MARK: State
    @State private var dataTest: Loadable<[Rentor]>
    @State private var dataSources: [Rentor] = []
    @State private var displayAlert: Bool = false
    @State private var messageAlert: String = ""
    @State private var headerList: String = ""
    @State private var showingSimmualatorView: Bool = false
    
    // MARK: ViewModel
    private let homeViewModel: HomeViewModel
    private let output: HomeViewModel.Output
    private let onDelete: PassthroughSubject<Rentor, Never>
    
    private let onTestError: PassthroughSubject<Void, Never>
    
    // MARK: Drawing Constants
    private let navigationBarTitle: String = "Home 🏡"
    private let alertErrorTitle: String = "An error occured"
    private let fontScaleFactor: CGFloat = 0.04
    
    init(rentor: Loadable<[Rentor]> = .notRequested) {

        self._dataTest = .init(initialValue: rentor)
        
        self.onDelete = PassthroughSubject<Rentor, Never>()
        self.onTestError = PassthroughSubject<Void, Never>()
        self.homeViewModel = HomeViewModel()
        self.output = self.homeViewModel.transform(
            HomeViewModel.Input(onDeleteSource: self.onDelete.eraseToAnyPublisher()))
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                self.body(with: geometry.size)
            }
        }
    }
    
    var notRequestedView: some View {
        Text("").onAppear {
        }
    }
    
    private var content: AnyView {
        switch self.dataTest {
        case .notRequested: return AnyView(notRequestedView)
        case let .isLoading(value): return AnyView(notRequestedView)
        case let .loaded(value): return AnyView(self.displayRentals())
        case let .failed(error): return AnyView(notRequestedView)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    private func displayBackgroundImage(with name: String) -> some View {
        Image(name).resizable().edgesIgnoringSafeArea(.top).frame(height: 150)
    }

    private func navigationBarAdd() -> some View {
        Button {
            self.showingSimmualatorView.toggle()
        } label: {
            Image(systemName: "plus")
                .imageScale(.large)
                .foregroundColor(Color.init("LightBlue"))
        }.sheet(isPresented: $showingSimmualatorView) {
            SimmulatorView(self.$showingSimmualatorView)
        }
    }
    
    private func headerListView() -> some View {
        Text(self.headerList.concat(string: "$US / month 💵"))
            .onReceive(self.output.headerListValue) { (value) in
                self.headerList = value
        }.foregroundColor(Color.init("LightBlue"))
        .font(.system(size: 16, weight: .bold))
    }
    
    private func displayRentals() -> some View {
        self.displayRentalProperties()
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .padding(.bottom, 4)
            .padding(.top, 4)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.black.opacity(0.05))
    }
    
    private func body(with size: CGSize) -> some View {
        List {
            Section(header: self.headerListView()) {
                self.displayRentals()
            }
        }.font(Font.system(size: self.fontSize(for: size)))
        .navigationBarItems(trailing: self.navigationBarAdd())
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text(self.navigationBarTitle), displayMode: .automatic)
    }
    
    private func displayErrorOccured(message: String) {
        self.displayAlert = true
        self.messageAlert = message
    }
    
    private func displayRentalProperties() -> some View {
        ForEach(self.dataSources) { rentalProperty in
            ZStack {
                RentalContentView(with: rentalProperty)
                NavigationLink(destination: HomeDetailView(with: rentalProperty)) {
                    EmptyView()
                }.frame(width: 0)
                .opacity(0)
                .buttonStyle(PlainButtonStyle())
            }.listRowBackground(Color.clear)
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
        }.onReceive(self.output.onUpdate) { updateValue in
            if let update = updateValue {
                self.dataSources.append(update)
            }
        }
    }
}
