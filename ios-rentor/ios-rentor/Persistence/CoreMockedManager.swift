//
//  CoreMockedManager.swift
//  ios-rentor
//
//  Created by Thomas on 17/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import Combine

internal protocol MockedProtocol {
    
}

internal final class CoreMockedManager<Entity> where Entity: MockedProtocol {
    private var generateError: Bool = true
    private let fileName: String
    
    init(with fileName: String) {
        self.fileName = fileName
    }
    
    internal func fetchMocked() -> AnyPublisher<[Entity], CoreError> {
        let loadingTimeRandom = Double.random(in: 0..<5)
        print("Loading time = \(loadingTimeRandom)")
        return Future<[Entity], CoreError> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + loadingTimeRandom) {
                self.generateError = !self.generateError
                print("generate Error = \(self.generateError)")
                if self.generateError {
                    print("Inside do")
                    do {
                        if let path = Bundle.main.path(forResource: "Home", ofType: "json") {
                            do {
                                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                                print(jsonResult)
                                print("INSIDE HERE ***")
                                promise(.success([]))
                            } catch { print("mdr toi")
                                print("INSIDE HERE ERROR ***")
                                promise(.failure(.fetchMockedError))
                            }
                        }
                    }
                }
                promise(.failure(.fetchMockedError))
            }
        }.eraseToAnyPublisher()
    }
}
