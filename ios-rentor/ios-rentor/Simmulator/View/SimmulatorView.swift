//
//  SimmulatorView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI
import Combine

fileprivate typealias EditEvent = (() -> ())

fileprivate struct CustomNavigationBarItems: View {
    @Binding fileprivate var event: EditEvent
    
    var body: some View {
        HStack {
            Button(action: self.event) {
                Text("Save")
            }
        }
    }
}

internal struct SimmulatorCellView: View {
    
    private let name: String
    private let currentCell: SimmulatorFormCellData
    
    private let increaseEvent = CurrentValueSubject<SimmulatorFormCellData?, Never>(nil)
    private let decreaseEvent = CurrentValueSubject<SimmulatorFormCellData?, Never>(nil)
    private let viewModel: SimmulatorViewModel
    
    @State private var stateTextField: Int = 0
    
    //MARK: Drawing Constants
    private let imageSystemNameLeft: String = "plus"
    private let imageSystemNameRight: String = "minus"
    
    private enum actionType: Int {
        case increase
        case decrease
    }
    
    init(with name: String, with vm: SimmulatorViewModel, and cell: SimmulatorFormCellData) {
        self.name = name
        self.viewModel = vm
        self.currentCell = cell
        _ = self.viewModel.transform(SimmulatorViewModel.Input(increaseEvent:
            self.increaseEvent.eraseToAnyPublisher(), decreaseEvent:
            self.decreaseEvent.eraseToAnyPublisher()))
        
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        HStack(alignment: .center) {
            self.headerViewCell(with: name)
            Spacer()
            self.bodyViewCell(with: self.currentCell)
                .frame(width: 80, alignment: .trailing)
        }
    }
    
    private func headerViewCell(with name: String) -> some View {
        VStack(alignment: .trailing) {
            Text(name)
        }
    }
    
    private func bodyViewCell(with value: SimmulatorFormCellData) -> some View {
        HStack(alignment: .center, spacing: 0) {
            self.bodyViewButton(image: self.imageSystemNameLeft, with: value, type: .increase)
            TextField("", value: self.$stateTextField, formatter: NumberFormatter())
                .autocapitalization(.none)
                .multilineTextAlignment(.trailing)
                .frame(width: 80, alignment: .center)
                .padding(.leading, 4)
                .padding(.trailing, 4)
            .buttonStyle(BorderlessButtonStyle())
            .onReceive(currentCell.value) { value in
                self.stateTextField = value
            }
            self.bodyViewButton(image: self.imageSystemNameRight, with: value, type: .decrease)
        }.overlay ( RoundedRectangle(cornerRadius: 8).stroke(Color.black.opacity(0.05), lineWidth: 2) )
    }
    
    private func bodyViewButton(image name: String, with cell: SimmulatorFormCellData, type: actionType) -> some View {
        Button(action: {
            type == .increase ? self.increaseEvent.send(cell) : self.decreaseEvent.send(cell)
        }) {
            Image(systemName: name).font(.system(size: 24))
                .foregroundColor(Color.black.opacity(0.7))
        }.padding(.leading, 8)
         .padding(.trailing, 8)
         .padding(.top, 4)
         .padding(.bottom, 4)
         .background(Color.black.opacity(0.05))
        .cornerRadius(8)
        .buttonStyle(BorderlessButtonStyle())
    }
}

internal struct SimmulatorView: View {
    @State private var eventTrigger: EditEvent = { }
    @State private var dataSources: [GlobalFormCell] = []
    @State private var isFormValid: Bool = false
    
    private let simmulatorViewModel: SimmulatorViewModel
    private let output: SimmulatorViewModel.Output
    
    //MARK: Drawing Constants
    private let fontScaleFactor: CGFloat = 0.04
    private let navigationBarTitle: String = "Simmulations"
    private let saveButtonTitle: String = "Done"
    
    init() {
        self.simmulatorViewModel = SimmulatorViewModel()
        self.output = self.simmulatorViewModel.transform(SimmulatorViewModel.Input())
        
        UITableView.appearance().backgroundColor = UIColor.black.withAlphaComponent(0.05)
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                self.body(with: geometry.size)
            }.navigationBarTitle(Text(self.navigationBarTitle))
            .navigationBarItems(trailing: CustomNavigationBarItems(event: self.$eventTrigger))
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    private func shouldRenderText(with title: String?) -> some View {
        title == nil ? AnyView(EmptyView()) : AnyView(Text(title ?? ""))
    }
    
    private func body(with size: CGSize) -> some View {
        return Form {
            ForEach(self.dataSources, id: \.id) { section in
                Section(header: self.shouldRenderText(with: section.header), footer: Text("_ Temporary Footer _")) {
                    VStack {
                        ForEach(section.data, id: \.id) { cell in
                            self.bodyContentCell(with: cell.name, and: cell)
                        }
                    }.padding()
                    .background(Color.white)
                    .cornerRadius(16)
                }
            }
            Section {
                Button(action: {
                    print("has to be valid")
                }) {
                    Text(self.saveButtonTitle)
                }.disabled(!self.isFormValid)
                    .onReceive(self.output.isFormValid) { isValid in
                    self.isFormValid = isValid
                }
            }
        }.onReceive(self.output.dataSources) { dataSources in
            self.dataSources = dataSources
        }
    }
    
    private func displayErrorMessage(with error: String) -> some View { Text(error).foregroundColor(Color.red) }
    
    private func bodyContentCell(with name: String, and cell: SimmulatorFormCellData) -> some View {
        SimmulatorCellView(with: name, with: self.simmulatorViewModel, and: cell)
    }
    
    private func handleEditEvent() {
        print("* handle event *")
    }
}
