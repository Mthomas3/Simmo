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
    
    internal func fetchTest() -> AnyPublisher<[Entity], CoreDataError> {
        let number = Double.random(in: 0..<5)
        
        return Future<[Entity], CoreDataError> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + number) {
                let randomError = Int.random(in: 0..<2)
                if randomError == 0 {
                    do {
                        promise(.success(try self.context.fetch(self.request)))
                    } catch {
                        promise(.failure(.fetchError))
                    }
                } else {
                    promise(.failure(.fetchError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func fetchCoreMocked() -> AnyPublisher<[Entity], CoreDataError> {
        let randomLoadingTime = Double.random(in: 0..<5)
        
        return Future<[Entity], CoreDataError> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + randomLoadingTime) {
                let generateRandomError = Int.random(in: 0..<2)
                if generateRandomError == 0 {
                    do {
                        
                        let path = Bundle.main.path(forResource: "Home", ofType: "json")
                        
                        print("SHOWING PATH = \(path)")
                        
                        promise(.success(try self.context.fetch(self.request)))
                    } catch { promise(.failure(.fetchError)) }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func fetchCore() -> AnyPublisher<[Entity], CoreDataError> {
        Future<[Entity], CoreDataError> {
            do {
                $0(.success(try self.context.fetch(self.request)))
            } catch { $0(.failure(.fetchError)) }
        }.eraseToAnyPublisher()
    }
    
    internal func fetch() -> AnyPublisher<[Entity], CoreDataError> {
        UserDefaults.standard.bool(forKey: "DEBUG") ? self.fetchCoreMocked() : self.fetchCore()
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
