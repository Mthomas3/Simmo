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

internal enum CoreDataError: Error {
    case fetchError
    case updateError
    case deleteError
    case createError
}

internal final class CoreDataManager {
    
    internal static let sharedInstance = CoreDataManager()
    private let coreDataContainer: NSPersistentContainer
    
    private init() {
        self.coreDataContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    private var context: NSManagedObjectContext {
        return self.coreDataContainer.viewContext
    }
    
    private func isExist(with name: String) throws -> Bool {
        let fetchRequest = RentorEntity.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        return try self.context.fetch(fetchRequest).count > 0 ? false : true
    }

    internal func createRental(with rental: RentorEntity) throws {
        let result = try self.isExist(with: rental.name ?? "")
        if (!result) {
            
            rental.cashFlow = 850.0
            rental.price = 150000.0
            rental.percentageEffiency = 6.8
            rental.rentPrice = 850.0
            
            self.context.insert(rental)
            try self.context.save()
        }
    }
    
    internal func fetchData<T: NSManagedObject>(type: T.Type) -> AnyPublisher<[T]?, CoreDataError> {
        do {
            return Just(try self.context.fetch(T.fetchRequest()) as? [T])
                    .retry(2)
                    .mapError { _ in CoreDataError.createError }
                    .eraseToAnyPublisher()
        } catch {
            return Just([])
                .mapError { _ in CoreDataError.createError }
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
    
    internal func deleteRental(with rental: RentorEntity) throws {
        self.context.delete(rental)
        try self.context.save()
    }
    
    internal func deleteRental(with name: String) throws {
        let fetchRequest = RentorEntity.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        fetchRequest.predicate = NSPredicate(format: "id == %@", name)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try self.context.execute(deleteRequest)
        try self.context.save()
    }
    
    internal func updateRental(with name: String) { }
    
    internal func fetchRental() -> NSFetchRequest<RentorEntity>  {
        let request: NSFetchRequest<RentorEntity> = RentorEntity.fetchRequest() as! NSFetchRequest<RentorEntity>
        request.sortDescriptors = [NSSortDescriptor(key: "createDate", ascending: true)]
        return request
    }

}



