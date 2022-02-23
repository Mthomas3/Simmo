//
//  SimmulatorListView1.swift
//  ios-rentor
//
//  Created by Thomas on 25/07/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI
import Combine

struct LineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding([.leading, .top, .bottom], 8)
            .padding(.trailing, 12)
            .frame(height: 56)
            .cornerRadius(20)
            .font(.system(size: 24))
    }
}

struct SimulatorInformation2: View {
    
    @Binding var shouldPopToRootView: Bool
    @State private var cardSelected: Int?
    @State private var isCurrentSelected: Int?
    @State private var nextButton: Bool = false
    @State private var nexStep: Bool = false
    @State internal var name: String = ""
    
    @EnvironmentObject private var store: AppStore
        
    @State private var colorSelected: Int = 0
    @State private var imageSelected: Int = 0
    
    let dataColor: [String] = (0...11).map { "Color\($0)" }
    let dataImage: [String] = (0...19).map { "Image\($0)" }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    private func colorRoundedView(with color: Color, and index: Int) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(colorSelected == index ? Color.init("Blue")
                                : Color.clear, lineWidth: colorSelected == index ? 3 : 0)
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .foregroundColor(color))
                .frame(width: 66, height: 66)
        }.onTapGesture {
            self.colorSelected = index
        }
    }
    
    private func imageRoundedView(with image: String, and index: Int) -> some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(imageSelected == index ? Color.init("Blue")
                                : Color.clear, lineWidth: imageSelected == index ? 3 : 0)
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .foregroundColor(Color.white))
                .frame(width: 66, height: 66)
            Image(image)
                .resizable()
                .frame(width: 30, height: 31)
                .aspectRatio(contentMode: .fill)
        }.onTapGesture {
            self.imageSelected = index
        }
    }
    
    private func simulatorTitleEvent() -> some View {
        TextField(Constant.title_center_city, text: $name)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
            .overlay(VStack { Divider().offset(x: 0, y: 15) })
    }
    
    private func currentSelectedRoundedView() -> some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 66, height: 66)
                .foregroundColor(Color.init(self.dataColor[self.colorSelected]))
            Image(self.dataImage[self.imageSelected])
                .resizable()
                .frame(width: 30, height: 31)
                .aspectRatio(contentMode: .fit)
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextTitle(title: Constant.title_set_name_investment)
            HStack(alignment: .center) {
                Spacer()
                currentSelectedRoundedView()
                simulatorTitleEvent()
                Spacer()
            }.padding([.leading, .trailing], 18)
            .padding(.bottom, 12)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<self.dataColor.count) { index in
                    colorRoundedView(with: Color.init(self.dataColor[index]), and: index)
                }
            }.padding(.horizontal)
            .padding(.bottom, 24)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<self.dataImage.count) { index in
                    imageRoundedView(with: self.dataImage[index], and: index)
                }
            }.padding(.horizontal)
        }
    }
 
    var body: some View {
        SimulatorBackground(content: {
            content
        }, barTitle: nil)
        .navigationBarItems(trailing: Button(action: {
            if var sim = self.store.state.simulatorState.informations {
                sim.color = self.dataColor[self.colorSelected]
                sim.image = self.dataImage[self.imageSelected]
                sim.name = self.name
                sim.isDone = true
                sim.isChecked = true
                self.store.dispatch(.simulatorAction(action: .setInformations(informations: sim)))
                self.store.dispatch(.simulatorAction(action: .fetchActivities))
            }
            self.shouldPopToRootView = false
        }, label: {
            Text(Constant.save_and_quit)
        }).disabled(!(self.name.count > 0)))
    }
}
