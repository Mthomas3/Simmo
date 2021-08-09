//
//  SimulatorRowView.swift
//  ios-rentor
//
//  Created by Thomas on 24/06/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimulatorRowView: View {
    
    internal let currentEvent: Int
    internal let name: String
    internal let index: Int
    internal let isChecked: Bool
    internal let nextPages: AnyView
    
    @State private var nextStep = false
    @EnvironmentObject private var store: AppStore
    
    var body: some View {
        Group {
            if currentEvent == self.index {
                VStack(alignment: .leading) {
                    HStack {
                        Text(name)
                            .foregroundColor(Color.init("DarkGray"))
                            .fontWeight(.medium)
                        Spacer()
                        
                        //Image("check")
                    }
                    ZStack {
                        Button(action: {
                                self.nextStep.toggle() }, label: {
                            Text("Continuer")
                                .frame(width: 133, height: 56, alignment: .center)
                                .background(Color.init("Blue"))
                                .foregroundColor(Color.white)
                                .buttonStyle(PlainButtonStyle())
                                .cornerRadius(12)
                        })
                        NavigationLink(
                            destination: nextPages,
                            isActive: $nextStep,
                            label: {
                                EmptyView().opacity(0)
                            }).isDetailLink(false)
                    }
                }
            } else {
                Group {
                    if currentEvent == 99 {
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(name)
                                        .foregroundColor(Color.init("HomeRowFontGray"))
                                    Text("Cette fonctionnalité sera bientôt disponible")
                                        .foregroundColor(Color.init("HomeRowFontGray"))
                                        .font(.system(size: 16))
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                        .frame(height: 50, alignment: .leading)
                                    
                                }
                                Spacer()
                                Image("check")
                                
                            }
                        }.frame(height: 70, alignment: .leading)
                    } else {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(name)
                                    .foregroundColor(Color.init("HomeRowFontGray"))
                                Spacer()
                               
                                Group {
                                    if isChecked {
                                        Image("check")
                                    }
                                }
                            }
                        }.frame(height: 35, alignment: .leading)
                    }
                }
            }
        }.padding(.leading, 25)
        .padding(.trailing, 25)
    }
}
