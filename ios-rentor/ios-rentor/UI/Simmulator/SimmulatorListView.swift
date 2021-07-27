//
//  SimmulatorListView.swift
//  ios-rentor
//
//  Created by Thomas on 22/06/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimmulatorListView: View {
    private let navigationBarTitle: String = "Simumation"
    var item: [Int] = [0, 1, 2]
    
    @EnvironmentObject private var store: AppStore
    @EnvironmentObject private var modalView: MainTabBarData
    
    var headerView: some View {
        VStack(alignment: .leading) {
            Button {
                self.modalView.close()
            } label: {
                Text("Fermer")
                    .foregroundColor(Color.white)
            }
            Spacer()
            Text("Ajoutons votre simulation")
                .frame(maxWidth: .infinity, alignment: .leading)
                .ignoresSafeArea()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .font(.system(size: 36))
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(height: 100, alignment: .leading)
        }.padding(.all, 8)
    }
    
    var SimulatorDivider: some View {
        Divider()
            .frame(height: 2, alignment: .center)
            .padding(.leading, 25)
            .padding(.trailing, 25)
    }

    var displayBody: some View {
        ZStack {
            VStack {
                ZStack {
                    Color.blue.edgesIgnoringSafeArea(.all)
                    headerView
                }.frame(height: 130, alignment: .leading)
                .padding(.bottom, 8)
                
                SimulatorRowView(testValue: 0, name: "Information sur le bien")
                SimulatorDivider
                SimulatorRowView(testValue: 1, name: "Financement")
                SimulatorDivider
                SimulatorRowView(testValue: 2, name: "Frais et charges")
                SimulatorDivider
                SimulatorRowView(testValue: 3, name: "Fiscalité")
                Spacer()
            }
        }
    }

    var body: some View {
        NavigationView {
            displayBody
                .navigationTitle(Text("SOMETHING HERE"))
                .navigationBarHidden(true)
        }
    }
}
