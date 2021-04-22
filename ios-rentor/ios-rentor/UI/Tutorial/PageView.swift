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
    
    let textWidth: CGFloat = 350
    let imageWidth: CGFloat = 150

    var body: some View {
        
        let size = UIImage(named: imageName)!.size
        let aspect = size.width / size.height

        return
            VStack(alignment: .center, spacing: 50) {
                Text(title)
                    .font(Font.system(size: 40, weight: .bold, design: .rounded))
                    .frame(width: textWidth)
                    .multilineTextAlignment(.center)
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(aspect, contentMode: .fill)
                    .frame(width: imageWidth, height: imageWidth)
                    
                VStack(alignment: .center, spacing: 5) {
                    Text("Step \(numberPage + 1)")
                        .font(Font.system(size: 25, weight: .bold, design: .rounded))
                        .frame(width: 300, alignment: .center)
                        .multilineTextAlignment(.center)
                    Text(content)
                        .font(Font.system(size: 18, weight: .bold, design: .rounded))
                        .frame(width: 300, alignment: .center)
                        .multilineTextAlignment(.center)
                }
            }.padding(60)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(numberPage: 0, title: "Lorem Ipsum",
                 imageName: "OnBoarding-House",
                 content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse iaculis egestas semper.")
    }
}
