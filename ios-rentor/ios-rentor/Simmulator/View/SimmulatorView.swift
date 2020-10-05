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
    //MARK: State
    @State private var dataSources: [GlobalFormCell] = []
    @State private var isFormValid: Bool = false
    
    //MARK: ViewModel
    private let simmulatorViewModel: SimmulatorViewModel
    private let output: SimmulatorViewModel.Output
    private let doneEvent = PassthroughSubject<Void, Never>()
    private let refreshEvent = PassthroughSubject<Void, Never>()
    
    //MARK: Drawing Constants
    private let fontScaleFactor: CGFloat = 0.04
    private let navigationBarTitle: String = "Simmulations"
    private let saveButtonTitle: String = "Done"
    
    init() {
        self.simmulatorViewModel = SimmulatorViewModel()
        self.output = self.simmulatorViewModel.transform(SimmulatorViewModel.Input(doneForm: self.doneEvent.eraseToAnyPublisher(), refreshEvent: self.refreshEvent.eraseToAnyPublisher()))
        
        UITableView.appearance().backgroundColor = UIColor.black.withAlphaComponent(0.05)
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                self.body(with: geometry.size)
            }.navigationBarTitle(Text(self.navigationBarTitle))
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
                Section(header: self.shouldRenderText(with: section.header), footer: self.shouldRenderText(with: section.errorMessage.value).foregroundColor(Color.red)) {
                    VStack {
                        ForEach(section.data, id: \.id) { cell in
                            self.bodyContentCell(with: cell.name, and: cell)
                        }
                    }.padding()
                    .background(Color.white)
                    .cornerRadius(16)
                }
            }.listRowInsets(EdgeInsets())
            Section {
                Button(action: {
                    self.doneEvent.send(())
                }) { Text(self.saveButtonTitle) }
                .disabled(!self.isFormValid)
                .onReceive(self.output.isFormValid) { isValid in
                    self.isFormValid = isValid
                }.buttonStyle(BlueButtonStyle(disabled: !self.isFormValid))
            }
        }.onReceive(self.output.dataSources) { dataSources in
            self.dataSources = dataSources
        }
    }
    
    private func bodyContentCell(with name: String, and cell: SimmulatorFormCellData) -> some View {
        SimmulatorCellView(with: name, and: cell, with: self.refreshEvent)
    }
}
