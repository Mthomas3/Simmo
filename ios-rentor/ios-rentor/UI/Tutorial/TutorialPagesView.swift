//
//  TutorialPagesView.swift
//  ios-rentor
//
//  Created by Thomas on 21/04/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI
import ConcentricOnboarding

struct TutorialPagesView: View {
    @EnvironmentObject var store: AppStore
      
    let colors = [
        Color.init("OnBoardingBlue"),
        Color.init("OnBoardingRed"),
        Color.init("OnBoardingViolet")
        ]
    
    let buttonColors = [
        Color.init("OnBoardingRed"),
        Color.init("OnBoardingBlue"),
        Color.init("DarkGray")
    ]
    
    var body: some View {
        
        let pages = store.state.settingsState.onBoardingPages.enumerated().map { (i, element) in
            AnyView(PageView(numberPage: i, title: element.title, imageName: element.image, content: element.content, textColor: Color.white))
        }
        
        var loadingPagesViews = ConcentricOnboardingView(pages: pages, bgColors: colors, nextIcon: "arrow.forward")
        //loadingPagesViews.clipShape(Circle())
        loadingPagesViews.iconNextColor = Color.white
        loadingPagesViews.buttonBackground = [Color.init("OnBoardingRed"),
                                              Color.init("OnBoardingBlue"),
                                              Color.init("DarkGray")]
        
        loadingPagesViews.buttonBackground = [Color.red, Color.yellow, Color.black]
        loadingPagesViews.buttonShape = AnyView(Rectangle().foregroundColor(buttonColors.first ?? Color.white).frame(width: 229, height: 68, alignment: .center).cornerRadius(12))
        
        loadingPagesViews.insteadOfCyclingToFirstPage = {
            store.dispatch(.settingsAction(action: .setHasLaunchedApp(status: true)))
        }
        
        return loadingPagesViews
    }
}

struct TutorialPagesView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPagesView()
    }
}
