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

fileprivate struct TitleBodyView: View {
    @State private var value: String = ""
    private let label: String
    
    init(label: String) {
        self.label = label
    }

    var body: some View {
        VStack(alignment: .trailing) {
            Text(self.label)
        }
    }
}

fileprivate struct ContentButton: View {
    private let name: String
    
    init(systemName name: String) {
        self.name = name
    }
    
    var body: some View {
        Button(action: { }) {
            Image(systemName: self.name).font(.system(size: 24))
                .foregroundColor(Color.black.opacity(0.7))
        }.padding(.leading, 8)
         .padding(.trailing, 8)
         .padding(.top, 4)
         .padding(.bottom, 4)
         .background(Color.black.opacity(0.05))
        .cornerRadius(8)
    }
}

fileprivate struct ContentBodyView: View {
    @State private var value: String = ""
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
            ContentButton(systemName: "plus")

            TextField("100000€", text: self.$value)
                .multilineTextAlignment(.trailing)
                .frame(width: 80, alignment: .center)
                .padding(.leading, 4)
                .padding(.trailing, 4)
            
           ContentButton(systemName: "minus")
             
        }.overlay ( RoundedRectangle(cornerRadius: 8) .stroke(Color.black.opacity(0.05), lineWidth: 2) )
    }
}


fileprivate struct ContentViewCell: View {
    
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            TitleBodyView(label: self.name)
            Spacer()
            ContentBodyView().frame(width: 80, alignment: .trailing)
        }
    }
}

internal struct SimmulatorView: View {
    @State private var eventTrigger: EditEvent = { }
    @Environment(\.managedObjectContext) private var managedObjectContext
    @State private var newRentalName: String = ""
    
    //MARK: Drawing Constants
    private let priceTitle: String = "Prix d'achat:"
    private let rentTitle: String = "Loyer mensuel:"
    private let percentageTitle: String = "Charges locatives:"
    private let headerTitle: String = "Charges annuelles:"
    private let fontScaleFactor: CGFloat = 0.04
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.black.withAlphaComponent(0.05)
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                self.body(with: geometry.size)
            }.navigationBarTitle(Text("Simmulations"))
            .navigationBarItems(trailing: CustomNavigationBarItems(event: self.$eventTrigger))
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    private func body(with size: CGSize) -> some View {
        List {
            Section {
                ContentViewCell(name: self.priceTitle)
                ContentViewCell(name: self.rentTitle)
                ContentViewCell(name: self.percentageTitle)
            }
            Section(header: Text(self.headerTitle)) {
                ContentViewCell(name: self.percentageTitle)
            }
            Section(header: Text(self.headerTitle)) {
                ContentViewCell(name: self.percentageTitle)
            }
        }.navigationBarTitle(Text("Home"), displayMode: .automatic)
        .navigationBarItems(trailing: EditButton())
        .listStyle(GroupedListStyle())
        .font(Font.system(size: self.fontSize(for: size)))
        .onAppear {
            self.eventTrigger = self.handleEditEvent
        }
    }
    
    private func handleEditEvent() {
        print("* handle event *")
    }
}
