//
//  SimmulatorListView1.swift
//  ios-rentor
//
//  Created by Thomas on 25/07/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI
import Combine

struct LineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding([.leading, .top, .bottom], 8)
            .padding(.trailing, 12)
            .frame(height: 56)
            .cornerRadius(20)
            .font(.system(size: 24))
    }
}

struct SimmulatorListView4: View {
    
    @Binding var shouldPopToRootView: Bool
    @State private var cardSelected: Int?
    @State private var isCurrentSelected: Int?
    @State private var nextButton: Bool = false
    @State private var nexStep: Bool = false
    @State internal var name: String = ""
    
    let dataColor = (1...12).map { "Item \($0)" }
    let dataImage = (1...20).map { "Item \($0)" }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    func customSelectView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 66, height: 66)
                .foregroundColor(.yellow)
        }
    }
    
    func customText() -> some View {
        TextField("T2 dans le centre de Montpellier", text: $name)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
            .overlay(VStack{Divider().offset(x: 0, y: 15)})
        
    }
 
    var body: some View {
        ScrollView {
            ZStack {
                Color.init("BackgroundHome")
                VStack(alignment: .leading, spacing: 8) {
                    Text("Donnez un titre à cet investissement")
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .font(.system(size: 34))
                        .frame(height: 140)
                        .padding(.leading, 24)
                        .padding(.trailing, 24)
                    
                    HStack(alignment: .center) {
                        Spacer()
                        customSelectView()
                        customText()
                        Spacer()
                    }.padding([.leading, .trailing], 18)
                    .padding(.bottom, 12)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(dataColor, id: \.self) { _ in
                            customSelectView()
                        }
                    }.padding(.horizontal)
                    .padding(.bottom, 24)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(dataImage, id: \.self) { _ in
                            customSelectView()
                        }
                    }.padding(.horizontal)
                }
            }
        }.navigationBarTitle(Text(""), displayMode: .inline)
        .background(Color.init("BackgroundHome").edgesIgnoringSafeArea(.all))
    }
    
    /*var body: some View {
        //ContentView()
    }*/
}


struct ContentView: View {
    let data = (1...100).map { "Item \($0)" }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            
        }
    }
}
