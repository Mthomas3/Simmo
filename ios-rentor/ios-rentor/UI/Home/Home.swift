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
    // MARK: State
    @State private var dataSources: [Rentor] = []
    @State private var displayAlert: Bool = false
    @State private var messageAlert: String = ""
    @State private var headerList: String = ""
    @State private var showingSimmualatorView: Bool = false
    
    //NEW***
    @EnvironmentObject var store: AppStore
    
    //**END
    
    // MARK: ViewModel
    private let homeViewModel: HomeViewModel?
    private let output: HomeViewModel.Output?
    private let onDelete: PassthroughSubject<Rentor, Never>?
        
    // MARK: Drawing Constants
    private let navigationBarTitle: String = "Home 🏡"
    private let alertErrorTitle: String = "An error occured"
    private let fontScaleFactor: CGFloat = 0.04
        
    init() {
        //self.onDelete = PassthroughSubject<Rentor, Never>()
        //self.homeViewModel = HomeViewModel()
        //self.output = self.homeViewModel.transform(
          //  HomeViewModel.Input(onDeleteSource: self.onDelete.eraseToAnyPublisher()))
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        self.homeViewModel = nil
        self.onDelete = nil
        self.output = nil
    }

    var body: some View {
        return NavigationView {
            GeometryReader { geometry in
                //self.body(with: geometry.size)
                Text("")
            }
        }
    }
    
    private func triggerLoadingData() {
        //self.store.dispatch(.action(action: .fetch))
    }
    
    func reloadView() {
        self.store.dispatch(.homeAction(action: .fetch))
    }
    
    private func nRenderBody(with size: CGSize) -> some View {
        
        let shouldDisplayError = Binding<Bool>(
            get: { self.store.state.homeState.fetchError != nil },
            set: { _ in self.store.dispatch(.homeAction(action: .fetchError(error: nil))) }
        )
        
        return Text("")
        
//        return ZStack {
//            if self.store.state.homeState.fetchInProgress {
//                ProgressView("Fetching database...")
//            } else {
//                VStack {
//                    List {
//                        ForEach(self.store.state.homeState.current) { property in
//                            Text(property.name ?? "")
//                        }
//                    }
//                    Button("Tap me", action: { self.reloadView() })
//                }
//            }
//        }.alert(isPresented: shouldDisplayError) {
//            Alert(title: Text("An error has Ocurred"),
//                  message: Text(store.state.homeState.fetchError ?? ""),
//                  dismissButton: .default(Text("Retry...")) {
//                    self.reloadView()
//                  })
//        }
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
//        }.sheet(isPresented: $showingSimmualatorView) {
//            SimmulatorView(self.$showingSimmualatorView)
//            //TestImageView(isViewOpen: self.$showingSimmualatorView)
//        }
        }.sheet(isPresented: $showingSimmualatorView) {
            SimmulatorView(self.$showingSimmualatorView)
        }
    }
    
    private func headerListView() -> some View {
        Text(self.headerList.concat(string: "$US / month 💵"))
            .onReceive(self.output!.headerListValue) { (value) in
                self.headerList = value
        }.foregroundColor(Color.init("LightBlue"))
        .font(.system(size: 16, weight: .bold))
    }
    
    private func newerBody(with size: CGSize) -> some View {
        List {
            Section(header: Text(self.store.state.homeState.headerTitle)) {
                self.newerDisplayRentalProperties()
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    .padding(.bottom, 4)
                    .padding(.top, 4)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.black.opacity(0.05))
            }
        }.font(Font.system(size: self.fontSize(for: size)))
        .navigationBarItems(trailing: self.navigationBarAdd())
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text(self.navigationBarTitle), displayMode: .automatic)
    }
    
    private func body(with size: CGSize) -> some View {
        List {
            Section(header: self.headerListView()) {
                self.displayRentalProperties()
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    .padding(.bottom, 4)
                    .padding(.top, 4)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.black.opacity(0.05))
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
    
    private func nDisplayRentalProperties() -> some View {
        ForEach(self.dataSources) { property in
            ZStack {
                RentalContentView(with: property)
                NavigationLink(
                    destination: HomeDetailView(with: property)) { EmptyView() }
                    .frame(width: 0)
                    .opacity(0)
                    .buttonStyle(PlainButtonStyle())
            }.listRowBackground(Color.clear)
        }.onDelete { deleteIndex in
            if let currentIndex = deleteIndex.first {
                self.onDelete!.send(self.dataSources[currentIndex])
            }
        }
    }
        
    private func newerDisplayRentalProperties() -> some View {
        ForEach(0 ..< self.store.state.homeState.homeRentors.count) { indexProperty in
            ZStack {
                let rental = self.store.state.homeState.homeRentors[indexProperty]
                RentalContentView(with: rental)
                NavigationLink(destination: HomeDetailView(with: rental)) {
                    EmptyView()
                }.frame(width: 0)
                .opacity(0)
                .buttonStyle(PlainButtonStyle())
            }.listRowBackground(Color.clear)
        }
    }
    
    private func displayRentalProperties() -> some View {
        ForEach(0 ..< self.dataSources.count, id: \.self) { (index) in
            ZStack {
                let rental = self.dataSources[index]
                RentalContentView(with: rental)
                NavigationLink(destination: HomeDetailView(with: rental)) {
                    EmptyView()
                }.frame(width: 0)
                .opacity(0)
                .buttonStyle(PlainButtonStyle())
            }.listRowBackground(Color.clear)
        }.onDelete { indexSet in
            if let currentIndex = indexSet.first {
                self.onDelete!.send(self.dataSources[currentIndex])
            }
        }.alert(isPresented: self.$displayAlert) {
            Alert(title: Text(self.alertErrorTitle),
            message: Text(self.messageAlert),
            primaryButton: .cancel(), secondaryButton: .destructive(Text("Retry")))
        }.onReceive(self.output!.errorMessage) { messageValue in
            self.messageAlert = messageValue
        }.onReceive(self.output!.dataSources) { self.dataSources = $0 }
        .onReceive(self.output!.onUpdate) { updateValue in
            if let update = updateValue {
                self.dataSources.append(update)
            }
        }
    }
}
