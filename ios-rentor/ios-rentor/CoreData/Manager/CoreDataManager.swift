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
        do {
            return Just(try self.context.fetch(self.request))
                .retry(2)
                .mapError { _ in CoreDataError.fetchError }
                .eraseToAnyPublisher()
        } catch {
            return Just([])
                .retry(2)
                .mapError { _ in CoreDataError.fetchError }
                .eraseToAnyPublisher()
        }
    }
    
    internal func onUpdate() -> AnyPublisher<Entity, Never> {
        return self.subject.eraseToAnyPublisher()
    }
    
    internal func create(with item: Entity) -> AnyPublisher<Void, CoreDataError> {
        do {
            self.context.insert(item)
            return Just(try self.context.save() as Void)
                .map {
                    self.subject.send(item)
                    return $0
                }
                .retry(2)
                .mapError { _ in CoreDataError.createError }
                .eraseToAnyPublisher()
        } catch {
            return Just(())
                .retry(2)
                .mapError { _ in CoreDataError.createError }
                .eraseToAnyPublisher()
        }
    }
    
    internal func delete(with item: Entity) throws {
        self.context.delete(item)
        try self.context.save()
    }
    
    internal func deleteOn(with data: Entity) -> AnyPublisher<Void, CoreDataError> {
        do {
            self.context.delete(data)
            return Just(try self.context.save() as Void)
                .retry(2)
                .mapError { _ in CoreDataError.deleteError }
                .eraseToAnyPublisher()
        } catch {
            return Just(())
                .mapError { _ in CoreDataError.deleteError }
                .eraseToAnyPublisher()
        }
    }
}
