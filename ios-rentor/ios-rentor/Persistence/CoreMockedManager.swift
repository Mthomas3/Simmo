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

internal final class CoreMockedManager<Entity> where Entity: Decodable {
    private var generateError: Bool = false
    private let fileName: String
    
    init(with fileName: String) {
        self.fileName = fileName
    }
    
    internal func fetchMocked() -> AnyPublisher<[Entity], CoreError> {
        let loadingTimeRandom = Double.random(in: 0..<5)
        return Future<[Entity], CoreError> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + loadingTimeRandom) {
                self.generateError = !self.generateError
                if self.generateError {
                    do {
                        if let path = Bundle.main.path(forResource: "Home", ofType: "json") {
                            do {
                                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                                let jsonResult = try JSONDecoder().decode([Rentor].self, from: data)
                                if let json = jsonResult as? [Entity] {
                                    promise(.success(json))
                                }
                                promise(.failure(.fetchMockedError))
                            } catch {
                                print("error")
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
