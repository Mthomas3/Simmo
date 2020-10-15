//
//  CoreDataObject.swift
//  ios-rentor
//
//  Created by Thomas on 15/10/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine

protocol CoreDataObject {
    associatedtype Entity
    
    func create(with item: Entity) -> AnyPublisher<Void, CoreDataError>
    func delete(with item: Entity) throws
    func update(with item: Entity)
    func fetch() -> AnyPublisher<[Entity], CoreDataError>
    func deleteOn(with item: Entity) -> AnyPublisher<Void, CoreDataError>
    func onUpdate() -> AnyPublisher<Entity, Never>
}
