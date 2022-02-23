//
//  SimulatorFunding0.swift
//  ios-rentor
//
//  Created by Thomas on 10/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimulatorFunding0: View {
    @EnvironmentObject private var store: AppStore
    @Binding var shouldPopToRootView: Bool
    @State private var isCurrentSelected: Int?
    @State private var financementType: Int?
    @State private var nextButton: Bool = false
    @State private var moveToNextStep: Bool = false
    @State private var opacity: Double = 1
    @State internal var name: String = ""
    @State private var text: String = ""
    
    private var ownProcessFunding: some View {
        LazyVStack(alignment: .center, spacing: 12) {
            PriceView(title: Constant.title_giving_part,
                      placeHolderTextField: Constant.place_holder_giving_part,
                      textfieldValue: $text,
                      opacity: $opacity)
            
            PriceView(title: Constant.title_price_funding,
                      placeHolderTextField: Constant.place_holder_price_funding,
                      textfieldValue: $text,
                      opacity: $opacity)
        }
    }
    
    private var bankingProcess: some View {
        LazyVStack(alignment: .center, spacing: 12) {
            PriceView(title: Constant.title_giving_part,
                      placeHolderTextField: Constant.place_holder_giving_part,
                      textfieldValue: $text,
                      opacity: $opacity)
            
            PriceView(title: Constant.title_price_funding,
                      placeHolderTextField: Constant.place_holder_price_funding,
                      textfieldValue: $text,
                      opacity: $opacity)
            
            PriceView(title: Constant.title_secure_funding,
                      placeHolderTextField: Constant.place_holder_secure_funding,
                      textfieldValue: $text,
                      opacity: $opacity)
            
            PriceView(title: Constant.title_rate_funding,
                      placeHolderTextField: Constant.place_holder_rate_funding,
                      textfieldValue: $text,
                      opacity: $opacity)
        }
    }
    
    private func displayFunding() -> some View {
        Group {
            if financementType == 0 { bankingProcess } else { ownProcessFunding }
        }
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.init("BackgroundHome")
                VStack(alignment: .leading, spacing: 30) {
                    TextTitle(title: Constant.title_type_funding)
                    HStack(alignment: .center) {
                        Spacer()
                        ButtonOption(eventButtonSelect: self.$financementType,
                                     nextButton: self.$nextButton, title: Constant.title_loan, index: 0)
                        ButtonOption(eventButtonSelect: self.$financementType,
                                     nextButton: self.$nextButton, title: Constant.title_own_funding, index: 1)
                        Spacer()
                    }
                    
                    self.displayFunding()
                        .transition(.opacity)
                        .animation(.easeInOut, value: 1)
                        .opacity(financementType == 0 || financementType == 1 ? opacity : 0)
                }
            }.padding(.bottom, 70)
        }.navigationBarTitle(Text(Constant.title_empty), displayMode: .inline)
        .background(Color.init("BackgroundHome").edgesIgnoringSafeArea(.all))
        .overlay(
            OverlayView(isActive: $moveToNextStep,
                        isHidden: !($text.wrappedValue.count > 3),
                        nextView: AnyView(SimulatorFundingLoan(shouldPopToRootView: self.$shouldPopToRootView)),
                        nextTitle: Constant.title_next,
                        callback: {
                            self.moveToNextStep.toggle()
                        }), alignment: .bottomTrailing)
    }
}
