//
//  SimulatorRowView.swift
//  ios-rentor
//
//  Created by Thomas on 24/06/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimulatorRowView: View {
    
    internal let currentViewType: CurrentEvent
    internal let name: String
    internal let typeView: CurrentEvent
    internal let isChecked: Bool
    internal let nextPages: AnyView
    
    @State private var nextStep = false
    @EnvironmentObject private var store: AppStore
    
    var bodyCurrentType: some View {
        VStack(alignment: .leading) {
            HStack {
                TextBold(title: name)
                Spacer()
            }
            ZStack {
                Button(action: {
                    self.nextStep.toggle() },
                       label: {
                    NextButton(title: Constant.title_continue, isHidden: nil)
                    })
                NavigationLink(
                    destination: nextPages,
                    isActive: $nextStep,
                    label: {
                        EmptyView().opacity(0)
                    }).isDetailLink(false)
            }
        }
    }
    
    var bodySpecialEvent: some View {
        
        /// Not used yet, special event "available soon"
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    TextLightGray(title: name)

                    Text(Constant.title_soon_available)
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
    }
    
    var bodyOthersViewType: some View {
        VStack(alignment: .leading) {
            HStack {
                TextLightGray(title: name)
                Spacer()
                Group {
                    if isChecked {
                        Image("check")
                    }
                }
            }
        }.frame(height: 35, alignment: .leading)
    }
    
    var body: some View {
        Group {
            if currentViewType == typeView {
                bodyCurrentType
            } else {
                    bodyOthersViewType
                }
            }.padding(.leading, 25)
            .padding(.trailing, 25)
    }
}
