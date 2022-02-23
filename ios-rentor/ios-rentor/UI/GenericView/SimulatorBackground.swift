//
//  SimulatorBackground.swift
//  ios-rentor
//
//  Created by Thomas on 18/02/2022.
//  Copyright © 2022 Thomas. All rights reserved.
//

import SwiftUI

struct SimulatorBackground<Content>: View where Content: View {
    let barTitle: String?
    let builder: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content, barTitle title: String?) {
        builder = content
        barTitle = title
    }
    
    var body: some View {
        ScrollView {
            ZStack(content: builder)
                .padding(.bottom, 70)
        }.navigationBarTitle(Text(barTitle ?? ""), displayMode: .inline)
        .background(Color.init("BackgroundHome").edgesIgnoringSafeArea(.all))
    }
}
