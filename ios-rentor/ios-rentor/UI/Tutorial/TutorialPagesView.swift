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
        "F38181",
        "FCE38A"
        ].map { Color(hex: $0) }
    
    var body: some View {
        
        let pages = store.state.settingsState.onBoardingPages.enumerated().map { (i, element) in
            AnyView(PageView(numberPage: i, title: element.title, imageName: element.image, content: element.content))
        }
        
        var loadingPagesViews = ConcentricOnboardingView(pages: pages, bgColors: colors)
        
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
