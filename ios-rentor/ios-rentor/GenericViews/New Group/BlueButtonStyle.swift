//
//  BlueButtonStyle.swift
//  ios-rentor
//
//  Created by Thomas on 29/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct BlueButtonStyle: ButtonStyle {
    var disabled: Bool = false

  func makeBody(configuration: Self.Configuration) -> some View {
    return configuration.label
        .font(.headline)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .contentShape(Rectangle())
        .background(configuration.isPressed ? Color.blue.opacity(0.5) : (disabled ? Color.blue.opacity(0.5) : Color.blue))
        .foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : Color.white)
        .cornerRadius(8)
  }
}
