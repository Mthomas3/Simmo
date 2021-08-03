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
    @State private var nextButton: Bool = false
    
    @State private var isButtonSelected: Bool = false
    @State private var isCurrentSelected: Int = 0
    
    @State private var nexStep: Bool = false
    
    func boxView(with index: Int, name image: String, title name: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(isActive && selected == index ? Color.init("Blue")
                                : Color.init("cardBorderLine"), lineWidth: 2)
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .foregroundColor(Color.init("DefaultBackground")))
            VStack {
                Image(image)
                    .resizable()
                    .frame(width: 105, height: 105, alignment: .center)
                Text(name)
                    .foregroundColor(Color.init("DarkGray"))
                    .fontWeight(.medium)
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
                    }.cornerRadius(12)
                }
            }
        }.frame(width: 170, height: 220)
        .onTapGesture {
            if self.isActive == true {
                self.isActive = false
            }
            self.isActive.toggle()
            self.selected = index
        }
    }
    
    private func optionButtonView(with title: String, and index: Int) -> some View {
        Button(action: { self.nextButton = true
            self.isCurrentSelected = index
            self.isButtonSelected.toggle()
        }, label: {
            Group {
                if isButtonSelected && isCurrentSelected == index {
                    Text(title)
                        .frame(width: 155, height: 56)
                        .foregroundColor(Color.init("DarkGray"))
                        .background(Color.init("Blue"))
                        .cornerRadius(12)
                } else {
                    Text(title)
                        .frame(width: 155, height: 56)
                        .foregroundColor(Color.init("DarkGray"))
                        .background(Color.init("DefaultBackground"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 2).foregroundColor(Color.init("ButtonBorder")))
                }
            }
        })
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.init("BackgroundHome")
                VStack(alignment: .leading, spacing: 8) {
                    Text("Quel type de bien envisagez-vous de mettre en location?")
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .font(.system(size: 34))
                        .frame(height: 140)
                        .padding(.leading, 24)
                        .padding(.trailing, 24)
                    HStack {
                        Spacer()
                        boxView(with: 0, name: "Old", title: "Bien ancien")
                        boxView(with: 1, name: "New", title: "Bien neuf")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        boxView(with: 2, name: "Construction", title: "Terrain et construction")
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                        boxView(with: 3, name: "Renovate", title: "Bien ancien avec travaux")
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                        
                        Spacer()
                    }
                    
                    Text("Ce bien sera-t-il loué meublé?")
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .font(.system(size: 24))
                        .padding(.all, 24)
                        //.padding(.trailing, 24)
                    
                    HStack(alignment: .center) {
                        Spacer()
                        self.optionButtonView(with: "Oui", and: 0)
                        self.optionButtonView(with: "Non", and: 1)
                        Spacer()
                    }
                }
            }
        }.navigationBarTitle(Text(""), displayMode: .inline)
        .background(Color.init("BackgroundHome").edgesIgnoringSafeArea(.all))
        .overlay(
            ZStack {
                Button(action: { print("YOOO")
                    self.nexStep.toggle()
                }, label: { Text("Suivant")
                    .frame(width: 140, height: 56)
                    .foregroundColor(Color.white)
                    .background(Color.init("Blue")).cornerRadius(12)
                    .opacity(nextButton ? 1 : 0)
                    .padding(.trailing, 8)
                    .animation(.easeInOut(duration: 0.5))
                    
                    NavigationLink(
                        destination: SimmulatorListView3(),
                        isActive: $nexStep,
                        label: {
                            EmptyView().opacity(0)
                        })
            }
            
        )}, alignment: .bottomTrailing)
    }
}

struct SimmulatorListView2_Previews: PreviewProvider {
    static var previews: some View {
        SimmulatorListView2()
    }
}
