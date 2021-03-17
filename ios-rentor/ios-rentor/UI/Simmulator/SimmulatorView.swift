//
//  SimmulatorView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI
import Combine

internal struct SimmulatorView: View {
    // MARK: State
    @State private var dataSources: [GlobalFormCell] = []
    @State private var isFormValid: Bool = false
    @Binding internal var isViewOpen: Bool
    
    @EnvironmentObject var store: AppStore
    
    // MARK: ViewModel
    private let simmulatorViewModel: SimmulatorViewModel
    private let output: SimmulatorViewModel.Output
    private let doneEvent = PassthroughSubject<Void, Never>()
    private let refreshEvent = PassthroughSubject<Void, Never>()
    
    // MARK: Drawing Constants
    private let fontScaleFactor: CGFloat = 0.04
    private let navigationBarTitle: String = "Simmulations 🏗"
    private let saveButtonTitle: String = "Done"
    
    init(_ isViewOpen: Binding<Bool>) {
        _isViewOpen = isViewOpen
        self.simmulatorViewModel = SimmulatorViewModel()
        self.output = self.simmulatorViewModel
            .transform(SimmulatorViewModel.Input(doneForm:
                                                    self.doneEvent.eraseToAnyPublisher(), refreshEvent:
                                                        self.refreshEvent.eraseToAnyPublisher()))
        UITableView.appearance().backgroundColor = UIColor.black.withAlphaComponent(0.05)
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                self.body(with: geometry.size)
            }.navigationBarTitle(Text(self.navigationBarTitle), displayMode: .inline)
            .navigationBarItems(leading:
               Button("Cancel") {
                self.isViewOpen = false
               }, trailing:
               Button("Done") {
                let rentor: Rentor = Rentor(id: UUID(), date: Date(), name: "TITI?", price: 10.0, rentPrice: 12.0, cashFlow: 12.0, percentage: 1.0, offset: 0, isSwiped: true)
                self.store.dispatch(.action(action: .add(item: rentor)))

                self.doneEvent.send(())
                self.isViewOpen = false
               }.disabled(!self.isFormValid)
                .onReceive(self.output.isFormValid) { isValid in
                    self.isFormValid = isValid
                }
            )
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    private func shouldRenderText(with title: String?) -> some View {
        title == nil || title == "" ? AnyView(EmptyView()) : AnyView(Text(title ?? ""))
    }
    
    private func body(with size: CGSize) -> some View {
        Form {
            ForEach(self.dataSources, id: \.id) { section in
                Section(header: self.shouldRenderText(with: section.header),
                        footer: self.shouldRenderText(with: section.errorMessage.value).foregroundColor(Color.red)) {
                    VStack {
                        ForEach(section.data, id: \.id) { cell in
                            self.bodyContentCell(with: cell.name, and: cell)
                        }
                    }.padding()
                    .background(Color.white)
                    .cornerRadius(16)
                }
            }.listRowInsets(EdgeInsets())
        }.onReceive(self.output.dataSources) { dataSources in
            self.dataSources = dataSources
        }
    }
    
    private func bodyContentCell(with name: String, and cell: SimmulatorFormCellData) -> some View {
        SimmulatorCellView(with: name, and: cell, with: self.refreshEvent)
    }
}
