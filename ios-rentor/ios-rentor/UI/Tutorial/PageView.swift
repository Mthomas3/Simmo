//
//  PageView.swift
//  ios-rentor
//
//  Created by Thomas on 21/04/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct PageView: View {
    let numberPage: Int
    let title: String
    let imageName: String
    let content: String
    let textColor: Color
    
    let textWidth: CGFloat = 350
    let imageWidth: CGFloat = 120

    var body: some View {
        
        let size = UIImage(named: imageName)!.size
        let aspect = size.width / size.height

        return
            VStack(alignment: .center, spacing: 40) {
                Text(title)
                    .font(Font.system(size: 40, weight: .bold))
                    .frame(width: textWidth)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .foregroundColor(textColor)
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(aspect, contentMode: .fill)
                    .frame(width: imageWidth, height: imageWidth)
                    
                VStack(alignment: .center, spacing: 5) {
                    Text("Step \(numberPage + 1)")
                        .font(Font.system(size: 16, weight: .bold))
                        .frame(width: 300, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(textColor)
                    
                    Text(content)
                        .font(Font.system(size: 16))
                        .frame(width: 300, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(textColor)
                        .fixedSize(horizontal: false, vertical: true)

                        
                }
            }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(numberPage: 0, title: "Lorem Ipsum",
                 imageName: "OnBoarding-House",
                 content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse iaculis egestas semper.", textColor: Color.white)
    }
}
