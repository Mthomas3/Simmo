//
//  HomeAction.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation

internal enum HomeAction {
    case fetch
    case fetchComplete(home: [Rentor])
    case fetchError(error: HomeMiddlewareError?)
}
