//
//  TutorialPagesView.swift
//  ios-rentor
//
//  Created by Thomas on 21/04/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import SwiftUI
import ConcentricOnboarding

struct PageData {
    let title: String
    let image: String
    let content: String
}

struct TutorialPagesView: View {
    @EnvironmentObject var store: AppStore
      
    let colors = [
        "F38181",
        "FCE38A"
        ].map { Color(hex: $0) }
    
    var body: some View {
        let values: [PageData] = [.init(title: "Lorem Ipsum", image: "OnBoarding-project", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse iaculis egestas semper."),.init(title: "Lorem Ipsum", image: "OnBoarding-House", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse iaculis egestas semper")]
        
        let pages = values.enumerated().map { (i, element) in
            AnyView(PageView(numberPage: i, title: element.title, imageName: element.image, content: element.content))
        }
        
        let backgroundColor: [Color] = [.init("OnBoardingBackground"), .init("OnBoardingBackground")]
        
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
