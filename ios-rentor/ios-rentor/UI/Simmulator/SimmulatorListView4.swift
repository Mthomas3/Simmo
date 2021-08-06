//
//  SimmulatorListView1.swift
//  ios-rentor
//
//  Created by Thomas on 25/07/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI
import Combine

struct SimmulatorListView4: View {
    
    @Binding var shouldPopToRootView: Bool
    @State private var cardSelected: Int?
    @State private var isCurrentSelected: Int?
    @State private var nextButton: Bool = false
    @State private var nexStep: Bool = false
    
    func customSelectView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 66, height: 66)
                .foregroundColor(.yellow)
        }
    }
    
    func customText() -> some View {
        Text("YOLO THERE")
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
                    
                    HStack {
                        Spacer()
                            .frame(width: 14)
                        customSelectView()
                        customText()
                        Spacer()
                            .frame(width: 14)
                    }
                    
                }
            }
        }.navigationBarTitle(Text(""), displayMode: .inline)
        .background(Color.init("BackgroundHome").edgesIgnoringSafeArea(.all))
    }
}
