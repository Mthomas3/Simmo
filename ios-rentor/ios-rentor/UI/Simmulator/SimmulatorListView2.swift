//
//  SimmulatorListView2.swift
//  ios-rentor
//
//  Created by Thomas on 26/07/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimmulatorListView2: View {
    
    @EnvironmentObject private var store: AppStore
    @Binding var shouldPopToRootView: Bool
    @State private var cardSelected: Int?
    @State private var isCurrentSelected: Int?
    @State private var nextButton: Bool = false
    @State private var nexStep: Bool = false
 
    var body: some View {
        ScrollView {
            ZStack {
                Color.init("BackgroundHome")
                VStack(alignment: .leading, spacing: 8) {
                    Text("Quel type de bien envisagez-vous de mettre en location?")
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .font(.system(size: 34))
                        .frame(height: 140)
                        .padding(.leading, 24)
                        .padding(.trailing, 24)
                    HStack {
                        Spacer()
                        CardView(eventSelected: self.$cardSelected,
                                 index: 0, name: "Bien ancien", image: "Old")
                        CardView(eventSelected: self.$cardSelected,
                                 index: 1, name: "Bien neuf", image: "New")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        CardView(eventSelected: self.$cardSelected,
                                 index: 2, name: "Terrain et construction", image: "Construction")
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                        CardView(eventSelected: self.$cardSelected,
                                 index: 3, name: "Bien ancien avec travaux", image: "Renovate")
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                        Spacer()
                    }
                    
                    Text("Ce bien sera-t-il loué meublé?")
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .font(.system(size: 24))
                        .padding(.all, 24)
                    
                    HStack(alignment: .center) {
                        Spacer()

                        ButtonOption(eventButtonSelect: self.$isCurrentSelected,
                                     nextButton: self.$nextButton, title: "Oui", index: 0)
                        ButtonOption(eventButtonSelect: self.$isCurrentSelected,
                                     nextButton: self.$nextButton, title: "Non", index: 1)
                        Spacer()
                    }
                }
            }
        }.navigationBarTitle(Text(""), displayMode: .inline)
        .background(Color.init("BackgroundHome").edgesIgnoringSafeArea(.all))
        .overlay(
            ZStack {
                Button(action: {
                    let simulator = SimulatorInformation(type: SimulatorType(rawValue: self.cardSelected ?? 0),
                                                         rented: (self.isCurrentSelected ?? 0) == 0 ? true : false, owner: nil,
                                                         price: nil, name: nil, color: nil, image: nil)
                    self.store.dispatch(.simulatorAction(action: .setInformations(informations: simulator)))
                    self.nexStep.toggle()
                }, label: { Text("Suivant")
                    .frame(width: 140, height: 56)
                    .foregroundColor(Color.white)
                    .background(Color.init("Blue")).cornerRadius(12)
                    .opacity(nextButton ? 1 : 0)
                    .padding(.trailing, 8)
                    .animation(.easeInOut(duration: 0.5))
                    
                    NavigationLink(
                        destination: SimmulatorListView3(shouldPopToRootView: self.$shouldPopToRootView),
                        isActive: $nexStep,
                        label: {
                            EmptyView().opacity(0)
                        }).isDetailLink(false)
            }).allowsHitTesting(nextButton) }, alignment: .bottomTrailing)
    }

}
