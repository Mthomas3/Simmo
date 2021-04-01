//
//  HomeReducer.swift
//  ios-rentor
//
//  Created by Thomas on 12/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import SwiftUI

final class HomeReducer: ReducerProtocol {
    
    typealias State = HomeState
    typealias Action = HomeAction
    
    func reducer(state: inout HomeState, action: HomeAction) {
        switch action {
        case .fetchComplete(let rentors):
            state.homeRentors = rentors
        case .setHeaderName(name: let name):
            state.headerTitle = name
        default:
            break
        }
    }
}
