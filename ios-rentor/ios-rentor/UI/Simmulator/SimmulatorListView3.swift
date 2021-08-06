//
//  SimmulatorListView3.swift
//  ios-rentor
//
//  Created by Thomas on 03/08/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding([.leading, .top, .bottom], 8)
            .padding(.trailing, 12)
            .frame(height: 56)
            .cornerRadius(20)
            .font(.system(size: 24))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.init("DarkGray"), lineWidth: 1))
    }
}

struct TextView: View {
    @State internal var name: String = ""
    
    var body: some View {
        TextField("1 200 000 €", text: $name)
            .multilineTextAlignment(.trailing)
            .textFieldStyle(OvalTextFieldStyle())
            .padding(.leading, 24)
            .padding(.trailing, 24)
            
    }
}

struct SimmulatorListView3: View {
    
    @Binding var shouldPopToRootView : Bool
    
    @State internal var isCurrentSelected: Int?
    @State internal var nextButton: Bool = false
    @State private var opacity: Double = 1
    @State private var shouldLeave: Bool = true
    @Environment(\.presentationMode) var presentation
    @State internal var nextStep: Bool = false


    func displayPrice() -> some View {
        VStack(alignment: .leading) {
            Text("Quel est le prix du bien?")
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .font(.system(size: 24))
                .padding([.leading, .trailing, .top], 24)
                .padding(.bottom, 20)
            
            TextView()
        }.onAppear {
            withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                self.opacity = 1
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.init("BackgroundHome").edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 4) {
                Text("Êtes-vous propriétaire de ce bien?")
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .font(.system(size: 34))
                    .frame(height: 140)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                
                HStack(alignment: .center) {
                    Spacer()
                    ButtonOption(eventButtonSelect: self.$isCurrentSelected,
                                 nextButton: self.$nextButton, title: "Oui", index: 0)
                    ButtonOption(eventButtonSelect: self.$isCurrentSelected,
                                 nextButton: self.$nextButton, title: "Non", index: 1)
                    Spacer()
                }.padding(.bottom, 12)
                
                self.displayPrice()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1))
                    .opacity(self.isCurrentSelected == 0 ? self.opacity : 0)
                    
                Spacer()
            }
        }.navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            //self.presentation.wrappedValue.dismiss()
            self.shouldPopToRootView = false
        }, label: {
            Text("Enregistrer et quitter")
        }).disabled(!self.nextButton).opacity(self.nextButton ? 1 : 0) )
        .overlay(ZStack {
                    Button(action: { print("YOOO")
                        self.nextStep.toggle()
                    }, label: { Text("Suivant")
                        .frame(width: 140, height: 56)
                        .foregroundColor(Color.white)
                        .background(Color.init("Blue")).cornerRadius(12)
                        .opacity(nextButton ? 1 : 0)
                        .padding(.trailing, 8)
                        .animation(.easeInOut(duration: 0.5))
                        
                        NavigationLink(
                            destination: SimmulatorListView4(shouldPopToRootView: self.$shouldPopToRootView),
                            isActive: $nextStep,
                            label: {
                                EmptyView().opacity(0)
                            }).isDetailLink(false)
                }).allowsHitTesting(nextButton) }, alignment: .bottomTrailing)
    }
}
