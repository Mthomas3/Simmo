//
//  GenericShapes.swift
//  ios-rentor
//
//  Created by Thomas on 31/08/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path {path in
            path.move(to: CGPoint(x: 0, y: 35))
            
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 35))
            
            path.addArc(center: CGPoint(x: (rect.width / 2), y: 35), radius: 35, startAngle: .zero,
                        endAngle: .init(degrees: 180), clockwise: true)
        }
    }
}
