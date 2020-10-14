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

internal final class CoreDataManager {
    
    internal static let sharedInstance = CoreDataManager()
    private let coreDataContainer: NSPersistentContainer
    //private let itemUpdate = PassthroughSubject<, Never>()
    
    private init() {
        self.coreDataContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    private var context: NSManagedObjectContext { self.coreDataContainer.viewContext }
    
    private func isExist<T: NSManagedObject>(item: T) throws -> Bool {
        let fetchRequest = T.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", item)
        return try self.context.fetch(fetchRequest).count > 0
    }

    //MARK: Todo change anyPublisher to Future which is like single (but a lil bit diff tho) in rxS 👀
    internal func createData<T: NSManagedObject>(with data: T) -> AnyPublisher<Void, CoreDataError> {
        do {
            self.context.insert(data)
            return Just(try self.context.save() as Void)
                .retry(2)
                .mapError { _ in CoreDataError.createError}
                .eraseToAnyPublisher()
        } catch {
            return Just(())
                .mapError { _ in CoreDataError.createError }
                .eraseToAnyPublisher()
        }
    }
    
    internal func fetchData<T: NSManagedObject>() -> AnyPublisher<[T]?, CoreDataError> {
        do {
            return Just(try self.context.fetch(self.fetchRequest()))
                    .retry(2)
                    .mapError { _ in CoreDataError.fetchError }
                    .eraseToAnyPublisher()
        } catch {
            return Just([])
                .mapError { _ in CoreDataError.fetchError }
                .eraseToAnyPublisher()
        }
    }
    
    internal func deleteData<T: NSManagedObject>(with data: T) -> AnyPublisher<Void, CoreDataError> {
        do {
            self.context.delete(data)
            return Just(try self.context.save() as Void)
                .retry(2)
                .mapError {_ in CoreDataError.deleteError }
                .eraseToAnyPublisher()
        } catch {
            return Just(())
                .mapError {_ in CoreDataError.deleteError }
                .eraseToAnyPublisher()
        }
    }
    
    internal func updateData<T>(with item: T) {
        fatalError("updateData not implemented")
    }
    
    internal func deleteRental<T: NSManagedObject>(type: T.Type, with name: String) throws {
        let fetchRequest = T.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        fetchRequest.predicate = NSPredicate(format: "id == %@", name)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try self.context.execute(deleteRequest)
        try self.context.save()
    }
    
    internal func deleteRental<T: NSManagedObject>(with item: T) throws {
        self.context.delete(item)
        try self.context.save()
    }
    
    private func fetchRequest<T: NSManagedObject>() -> NSFetchRequest<T>  {
        let request: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        request.sortDescriptors = [NSSortDescriptor(key: "createDate", ascending: true)]
        return request
    }

}



