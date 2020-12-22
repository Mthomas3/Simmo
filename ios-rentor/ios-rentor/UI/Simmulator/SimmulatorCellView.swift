//
//  SimmulatorCellView.swift
//  ios-rentor
//
//  Created by Thomas on 28/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI
import Combine

internal struct SimmulatorCellView: View {
    // MARK: State
    @State private var stateTextField: Int = 0
    
    // MARK: ViewModel
    private let increaseEvent = PassthroughSubject<SimmulatorFormCellData, Never>()
    private let decreaseEvent = PassthroughSubject<SimmulatorFormCellData, Never>()
    private let viewModel: SimmulatorCellViewModel = SimmulatorCellViewModel()
    private let refreshEvent: PassthroughSubject<Void, Never>
 
    private let name: String
    private let currentCell: SimmulatorFormCellData
    
    // MARK: Drawing Constants
    private let imageSystemNameLeft: String = "minus"
    private let imageSystemNameRight: String = "plus"
    
    private enum ActionType: Int {
        case increase
        case decrease
    }
    
    init(with name: String, and cell: SimmulatorFormCellData, with refresh: PassthroughSubject<Void, Never>) {
        self.name = name
        self.currentCell = cell
        self.refreshEvent = refresh
        
        _ = self.viewModel.transform(SimmulatorCellViewModel.Input(increaseEvent:
            self.increaseEvent.eraseToAnyPublisher(), decreaseEvent:
            self.decreaseEvent.eraseToAnyPublisher()))
    }
    
    var body: some View {
        HStack(alignment: .center) {
            self.headerViewCell(with: name).padding(.trailing, 30)
            Spacer()
            self.bodyViewCell(with: self.currentCell)
                .frame(width: 80, alignment: .trailing)
        }
    }
    
    private func headerViewCell(with name: String) -> some View {
        VStack(alignment: .trailing) {
            Text(name)
                .font(.body)
                .fontWeight(.light)
                .truncationMode(.tail)
                
        }.padding(.trailing, 40)
        
    }
    
    private func bodyViewCell(with value: SimmulatorFormCellData) -> some View {
        HStack(alignment: .center, spacing: 0) {
            self.bodyViewButton(image: self.imageSystemNameLeft, with: value, type: .decrease)
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
            self.bodyViewButton(image: self.imageSystemNameRight, with: value, type: .increase)
        }.overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black.opacity(0.05), lineWidth: 2))
    }
    
    private func bodyViewButton(image name: String, with cell: SimmulatorFormCellData, type: ActionType) -> some View {
        Button(action: {
            type == .increase ? self.increaseEvent.send(cell) : self.decreaseEvent.send(cell)
            self.refreshEvent.send(())
        }) {
            Image(systemName: name)
                .font(.system(size: 24))
                .foregroundColor(Color.black.opacity(0.7))
                .frame(height: 20)
        }.padding(.leading, 8)
         .padding(.trailing, 8)
         .padding(.top, 4)
         .padding(.bottom, 4)
         .background(Color.black.opacity(0.05))
        .cornerRadius(8)
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct SimmulatorCellView_Previews: PreviewProvider {
    static var previews: some View {
        let refreshEvent = PassthroughSubject<Void, Never>()
        return SimmulatorCellView(with: "test A",
                                  and: SimmulatorFormCellData(cell: "Cell B",
                                                              isPercentage: false), with: refreshEvent)
    }
}
