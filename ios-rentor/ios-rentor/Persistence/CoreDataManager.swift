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

internal final class CoreDataManager<Entity> where Entity: NSManagedObject {
    private let request: NSFetchRequest<Entity>
    private let context: NSManagedObjectContext
    private let subject: PassthroughSubject<Entity, Never>
    
    init(request: NSFetchRequest<Entity>, context: NSManagedObjectContext) {
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
                $0(.success(try self.context.fetch(self.request)))
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
                self.context.insert(item)
                self.subject.send(item)
                $0(.success(try self.context.save() as Void))
            } catch {
                $0(.failure(.createError))
            }
        }.eraseToAnyPublisher()
    }
    
    internal func delete(with item: Entity) throws {
        self.context.delete(item)
        try self.context.save()
    }
    
    internal func deleteOn(with data: Entity) -> AnyPublisher<Void, CoreDataError> {
        Future<Void, CoreDataError> {
            do {
                self.context.delete(data)
                $0(.success(try self.context.save() as Void))
            } catch {
                $0(.failure(.deleteError))
            }
        }.eraseToAnyPublisher()
    }
}
