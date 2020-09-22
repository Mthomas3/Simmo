//
//  SimmulatorView.swift
//  ios-rentor
//
//  Created by Thomas on 29/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

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
    @State private var value: String = ""
    @ObservedObject private var viewModel: SimmulatorViewModel
    
    //MARK: Drawing Constants
    private let imageSystemNameLeft: String = "plus"
    private let imageSystemNameRight: String = "minus"
    private let bodyViewPlaceHolder: String = "100000€"
    
    
    init(with name: String, with vm: SimmulatorViewModel) {
        self.name = name
        self.viewModel = vm
        
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        HStack(alignment: .center) {
            self.headerViewCell(with: name)
            Spacer()
            self.bodyViewCell()
                .frame(width: 80, alignment: .trailing)
        }
    }
    
    private func headerViewCell(with name: String) -> some View {
        VStack(alignment: .trailing) {
            Text(name)
        }
    }
    
    @State var toto: Int = 0
    
    private func bodyViewCell() -> some View {
        HStack(alignment: .center, spacing: 0) {
            self.bodyViewButton(image: self.imageSystemNameLeft)
            TextField("", value: self.$viewModel.price, formatter: NumberFormatter())
                .autocapitalization(.none)
                .multilineTextAlignment(.trailing)
                .frame(width: 80, alignment: .center)
                .padding(.leading, 4)
                .padding(.trailing, 4)
            self.bodyViewButton(image: self.imageSystemNameRight)
        }.overlay ( RoundedRectangle(cornerRadius: 8) .stroke(Color.black.opacity(0.05), lineWidth: 2) )
    }
    
    private func bodyViewButton(image name: String) -> some View {
        Button(action: {
            self.viewModel.price += 2
        }) {
            Image(systemName: name).font(.system(size: 24))
                .foregroundColor(Color.black.opacity(0.7))
        }.padding(.leading, 8)
         .padding(.trailing, 8)
         .padding(.top, 4)
         .padding(.bottom, 4)
         .background(Color.black.opacity(0.05))
        .cornerRadius(8)
    }
}

internal struct SimmulatorView: View {
    @State private var eventTrigger: EditEvent = { }
    @Environment(\.managedObjectContext) private var managedObjectContext
    @State private var newRentalName: String = ""
    
    @ObservedObject private var simmulatorViewModel = SimmulatorViewModel()
    
    //MARK: Drawing Constants
    private let priceTitle: String = "Prix d'achat:"
    private let rentTitle: String = "Loyer mensuel:"
    private let percentageTitle: String = "Charges locatives:"
    private let headerTitle: String = "Charges annuelles:"
    private let fontScaleFactor: CGFloat = 0.04
    private let navigationBarTitle: String = "Simmulations"
    private let saveButtonTitle: String = "Done"
    
    init() {
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
    
    private func body(with size: CGSize) -> some View {
        Form {
            Section(footer: self.displayErrorMessage(with: self.simmulatorViewModel.formErrorMessage)) {
                VStack {
                    self.bodyContentCell(with: self.priceTitle)
                    self.bodyContentCell(with: self.rentTitle)
                    self.bodyContentCell(with: self.percentageTitle)
                    self.bodyContentCell(with: self.percentageTitle)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
            }
            Section(header: Text(self.headerTitle), footer: self.displayErrorMessage(with: self.simmulatorViewModel.formErrorMessage)) {
                VStack {
                    self.bodyContentCell(with: self.percentageTitle)
                    self.bodyContentCell(with: self.percentageTitle)
                }.padding()
                .background(Color.white)
                .cornerRadius(16)
            }
            Section(header: Text(self.headerTitle), footer: self.displayErrorMessage(with: self.simmulatorViewModel.formErrorMessage)) {
                VStack {
                    self.bodyContentCell(with: self.percentageTitle)
                    self.bodyContentCell(with: self.percentageTitle)
                }.padding()
                .background(Color.white)
                .cornerRadius(16)
            }
            Section {
                Button(action: {
                    print("need to be valid")
                }){
                    Text(self.saveButtonTitle)
                }.disabled(!self.simmulatorViewModel.isFormValid)
            }
        }.font(Font.system(size: self.fontSize(for: size)))
         .onAppear {
            self.eventTrigger = self.handleEditEvent
        }
    }
    
    private func displayErrorMessage(with error: String) -> some View { Text(error).foregroundColor(Color.red) }
    
    private func bodyContentCell(with name: String) -> some View {
        SimmulatorCellView(with: name, with: self.simmulatorViewModel)
    }
    
    private func handleEditEvent() {
        print("* handle event *")
    }
}
