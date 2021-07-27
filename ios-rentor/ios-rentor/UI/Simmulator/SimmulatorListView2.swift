//
//  SimmulatorListView2.swift
//  ios-rentor
//
//  Created by Thomas on 26/07/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct SimmulatorListView2: View {
    
    @State private var isActive = false
    @State private var selected: Int = 0
    
    func boxView(with index: Int) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .strokeBorder(isActive && selected == index ? Color.init("blueImage") : Color.init("cardBorderLine"), lineWidth: 4)
                .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .foregroundColor(Color.white))
            VStack {
                Image("ImageCard")
                    .resizable()
                    .frame(width: 90, height: 90, alignment: .center)
                Text("Bien ancien")
            }
            Group {
                if isActive == true && selected == index {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Spacer()
                            Image("cornerImage")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        Spacer()
                    }.cornerRadius(25)
                }
            }
        }.frame(width: 170, height: 220)
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.init("BackgroundHome")
                VStack {
                    Text("Quel type de bien envisagez-vous de mettre en location?")
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .font(.system(size: 32))
                    HStack {
                        boxView(with: 0)
                            .onTapGesture {
                                if self.isActive == true {
                                    self.isActive = false
                                }
                                self.isActive.toggle()
                                self.selected = 0
                            }
                        boxView(with: 1)
                            .onTapGesture {
                                if self.isActive == true {
                                    self.isActive = false
                                }
                                self.isActive.toggle()
                                self.selected = 1
                            }
                    }
                    HStack {
                        boxView(with: 2)
                            .onTapGesture {
                                if self.isActive == true {
                                    self.isActive = false
                                }
                                self.isActive.toggle()
                                self.selected = 2
                            }
                        boxView(with: 3)
                            .onTapGesture {
                                if self.isActive == true {
                                    self.isActive = false
                                }
                                self.isActive.toggle()
                                self.selected = 3
                            }
                    }
                }.padding(.top, 8)
                .padding(.leading, 6)
                .padding(.trailing, 6)
            }
        }.navigationBarTitle(Text(""), displayMode: .inline)
        .background(Color.init("BackgroundHome").edgesIgnoringSafeArea(.all))
        
    }
}

struct SimmulatorListView2_Previews: PreviewProvider {
    static var previews: some View {
        SimmulatorListView2()
    }
}
