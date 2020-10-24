//
//  HomeDetailView.swift
//  ios-rentor
//
//  Created by Thomas on 05/10/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct HomeDetailView: View {
    //MARK: State
    private let rentalSelected: RentorEntity
    
    //MARK: ViewModel
    private let homeDetailViewModel: HomeDetailViewModel
    private let output: HomeDetailViewModel.Output
    
    //MARK: Drawing Constants
    private let navigationBarTitle: String = "House Detail"
    private let fontScaleFactor: CGFloat = 0.04
    
    init(with rental: RentorEntity) {
        self.rentalSelected = rental
        
        self.homeDetailViewModel = HomeDetailViewModel()
        self.output = self.homeDetailViewModel.transform(HomeDetailViewModel.Input())
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(with: geometry.size)
        }
        .navigationBarTitle(Text(self.navigationBarTitle), displayMode: .inline)
    }

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    private func body(with size: CGSize) -> some View {
        Text("RENTOR HERE = \(self.rentalSelected.name ?? "not found")")
            .font(Font.system(size: self.fontSize(for: size)))
    }
}

struct HomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailView(with: RentorEntity())
    }
}
