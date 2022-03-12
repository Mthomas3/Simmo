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
    @State private var financementType: ButtonEventType?
    @State private var nextButton: Bool = false
    @State private var moveToNextStep: Bool = false
    @State private var opacity: Double = 1
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
    
    private var switchView: some View {
        Group {
            if financementType?.rawValue == 0 { bankingProcess } else { ownProcessFunding }
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 30) {
            TextTitle(title: Constant.title_type_funding)
            
            AskButtonView(value: $financementType,
                          nextButton: $nextButton,
                          first_title: Constant.title_loan,
                          second_title: Constant.title_own_funding)
            
            switchView
                .transition(.opacity)
                .animation(.easeInOut, value: 1)
                .opacity(financementType?.rawValue == 0 || financementType?.rawValue == 1 ? opacity : 0)
        }
    }
    
    var body: some View {
        SimulatorBackground(content: {
            content
        }, barTitle: nil)
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
