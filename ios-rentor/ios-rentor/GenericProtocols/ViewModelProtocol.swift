//
//  ViewModelProtocol.swift
//  ios-rentor
//
//  Created by Thomas on 23/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Output
    associatedtype Input
    
    func transform(_ input: Input) -> Output
}
