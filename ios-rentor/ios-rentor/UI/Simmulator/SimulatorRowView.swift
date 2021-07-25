//
//  SimulatorRowView.swift
//  ios-rentor
//
//  Created by Thomas on 24/06/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimulatorRowView: View {
    
    let testValue: Int
    let name: String
    
    var body: some View {
        Group {
            if testValue == 0 {
                VStack(alignment: .leading) {
                    HStack {
                        Text(name)
                            .foregroundColor(Color.init("DarkGray"))
                            .fontWeight(.medium)
                        Spacer()
                        Image("check")
                        
                    }
                    Button(action: { }, label: {
                        Text("Continue")
                            .frame(width: 133, height: 56, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color.init("PrimaryBlue"))
                            .cornerRadius(12)
                    }).buttonStyle(PlainButtonStyle())
                }
            } else {
                Group {
                    if testValue == 3 {
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
                                Image("check")
                                
                            }
                        }.frame(height: 35, alignment: .leading)
                    }
                }
            }
        }.padding(.leading, 25)
        .padding(.trailing, 25)
        
    }
}

struct SimulatorRowView_Previews: PreviewProvider {
    static var previews: some View {
        SimulatorRowView(testValue: 0, name: "TEST")
    }
}
