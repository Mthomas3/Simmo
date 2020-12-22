//
//  CoreDataPresenter.swift
//  ios-rentor
//
//  Created by Thomas on 05/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI
import Combine

internal final class CoreDataManager<Entity, T> where Entity: ModelsManagedEntity, T: NSManagedObject {
    private let request: NSFetchRequest<T>
    private let context: NSManagedObjectContext
    private let subject: PassthroughSubject<Entity, Never>
    
    init(request: NSFetchRequest<T>, context: NSManagedObjectContext) {
        if request.sortDescriptors == nil {
            request.sortDescriptors = []
        }
        self.request = request
        self.context = context
        self.subject = PassthroughSubject<Entity, Never>()
    }
    
    internal func fetch() -> AnyPublisher<[Entity], CoreDataError> {
        Future<[Entity], CoreDataError> {
            do {
                let res: [T] = try self.context.fetch(self.request)
                var result: [Entity] = []
                
                res.forEach { (item) in
                    if let value = item as? Entity.T {
                        if let initValue = Entity(managedObject: value) {
                            result.append(initValue)
                        }
                    }
                }
                $0(.success(result))
                //$0(.success(try self.context.fetch(self.request)))
            } catch {
                $0(.failure(.fetchError))
            }
        }.eraseToAnyPublisher()
    }
    
    internal func onUpdate() -> AnyPublisher<Entity, Never> {
        return self.subject.eraseToAnyPublisher()
    }
    
    internal func create(with item: Entity) -> AnyPublisher<Void, CoreDataError> {
        Future<Void, CoreDataError> {
            do {
                let coreItem: T = item.store(in: self.context) as! T
                self.context.insert(coreItem)
                self.subject.send(item)
                $0(.success(try self.context.save() as Void))
            } catch {
                $0(.failure(.createError))
            }
        }.eraseToAnyPublisher()
    }
    
    internal func delete(with item: Entity) throws {
        let coreItem: T = item.store(in: self.context) as! T
        self.context.delete(coreItem)
        try self.context.save()
    }
    
    internal func deleteOn(with data: Entity) -> AnyPublisher<Void, CoreDataError> {
        Future<Void, CoreDataError> {
            do {
                $0(.success(try self.context.save() as Void))
            } catch {
                $0(.failure(.deleteError))
            }
        }.eraseToAnyPublisher()
    }
}
