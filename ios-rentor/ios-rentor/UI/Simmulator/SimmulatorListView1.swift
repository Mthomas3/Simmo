//
//  SimmulatorListView1.swift
//  ios-rentor
//
//  Created by Thomas on 25/07/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI
import Combine

struct SimmulatorListView1: View {
    var body: some View {
        Text("SOMETHING HERE")
    }
}

struct SimmulatorListView1_Previews: PreviewProvider {
    static var previews: some View {
        SimmulatorListView1()
    }
}

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Dismiss Modal") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        Button("Present!") {
            isPresented.toggle()
        }
        .fullScreenCover(isPresented: $isPresented, content: FullScreenModalView.init)
    }
}

struct MainTabScene: View {

    @ObservedObject private var tabData = MainTabBarData(initialIndex: 1, customItemIndex: 2)

    var body: some View {
        TabView (selection: $tabData.itemSelected){

        // First Secection
        Text("First Section!")
        .tabItem {
            Image(systemName: "1.square.fill")
            Text("First!")
        }.tag(1)

        // Add Element
        Text("Custom Action")
        .tabItem {
            Image(systemName: "plus.circle")
            Text("Add Item")
        }
        .tag(2)

        // Events
        Text("Second Section!")
        .tabItem {
            Image(systemName: "2.square.fill")
            Text("Second")
        }.tag(3)

        }
        .font(.headline)
        .fullScreenCover(isPresented: $tabData.isCustomItemSelected, onDismiss: {
            print("dismiss")
        }) {
            //Text("Custom action modal")
            //SimmulatorListView()
        }
    }
}
