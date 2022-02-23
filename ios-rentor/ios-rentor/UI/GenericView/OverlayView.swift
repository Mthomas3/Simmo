//
//  OverlayView.swift
//  ios-rentor
//
//  Created by Thomas on 17/02/2022.
//  Copyright © 2022 Thomas. All rights reserved.
//

import SwiftUI

struct OverlayBody: View {
    let name: String
    let content: AnyView
    
    @Binding var isActive: Bool
    let isHidden: Bool
    
    var body: some View {
        return Group {
            NextButton(title: name, isHidden: isHidden)
            NavigationLink(destination: content, isActive: self.$isActive,
            label: { EmptyView().opacity(0) }).isDetailLink(false)
        }
    }
}

struct OverlayView: View {
    
    @Binding internal var isActive: Bool
    let isHidden: Bool
    
    let nextView: AnyView
    let nextTitle: String
    let callback: () -> Void
    
    var body: some View {
        ZStack {
            Button(action: {
                self.callback()
                }, label: {
                    OverlayBody(name: nextTitle,
                                content: nextView,
                               isActive: $isActive,
                                isHidden: isHidden)
            }).allowsHitTesting(!isActive) }
    }
    
}
