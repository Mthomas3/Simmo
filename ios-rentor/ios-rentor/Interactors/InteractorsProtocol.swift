//
//  InteractorsProtocol.swift
//  ios-rentor
//
//  Created by Thomas on 23/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine

internal protocol InteractorProtocol {
    associatedtype Output
    associatedtype Input
    
    func transform(_ input: Input) -> Output
}
