//
//  RentalDBRepository.swift
//  ios-rentor
//
//  Created by Thomas on 17/12/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine
import UIKit
import CoreData

protocol DBRepositoryProtocol {
    
    associatedtype CoreEntity
    associatedtype ModelEntity
    
    func create(with item: ModelEntity) -> AnyPublisher<Void, CoreDataError>
    func delete(with item: ModelEntity) throws
    func fetch() -> AnyPublisher<[ModelEntity], CoreDataError>
    func refresh() -> AnyPublisher<ModelEntity?, Never>
    func deleteOn(with item: ModelEntity) -> AnyPublisher<Void, CoreDataError>
}

internal final class RealRentalDBRepository: DBRepositoryProtocol {
    
    private let coreDataManager: CoreDataManager<RentorEntity>
    private let context: NSManagedObjectContext
    
    internal typealias CoreEntity = RentorEntity
    internal static let sharedInstance = RealRentalDBRepository()
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let request = RentorEntity.fetchRequest() as? NSFetchRequest<RentorEntity> else {
            fatalError("[SIMMO][ERROR] AppDelegate failed CoreDataRental")
        }
        self.context = appDelegate.persistentContainer.viewContext
        request.sortDescriptors = [NSSortDescriptor(key: "createDate", ascending: true)]
        self.coreDataManager = CoreDataManager<RentorEntity>(request: request,
                                                             context: appDelegate.persistentContainer.viewContext)
    }
    
    internal func create(with item: Rentor) -> AnyPublisher<Void, CoreDataError> {
        guard let rentorObject = item.store(in: self.context) else {
            return AnyPublisher(Fail<Void, CoreDataError>(error: .createError))
        }
        return self.coreDataManager.create(with: rentorObject)
    }

    internal func refresh() -> AnyPublisher<Rentor?, Never> {
        return self.coreDataManager.onUpdate()
            .map { Rentor(managedObject: $0) }
            .eraseToAnyPublisher()
    }
    
    internal func delete(with item: Rentor) throws {
        if let request = RentorEntity.fetchRequest() as? NSFetchRequest<RentorEntity> {
            request.predicate = NSPredicate(format: "name == %@", item.name ?? "")
            if let item = try self.context.fetch(request).first {
                try self.coreDataManager.delete(with: item)
            }
        }
    }
    
    internal func fetch() -> AnyPublisher<[Rentor], CoreDataError> {
        return self.coreDataManager.fetch().map { (rentorEntity) -> [Rentor] in
            return rentorEntity.map {
                return Rentor(managedObject: $0)
            }.compactMap {$0}
        }.eraseToAnyPublisher()
    }
    
    internal func deleteOn(with item: Rentor) -> AnyPublisher<Void, CoreDataError> {
        guard let rentorObject = item.store(in: self.context) else {
            return AnyPublisher(Fail<Void, CoreDataError>(error: .deleteError))
        }
        return self.coreDataManager.deleteOn(with: rentorObject)
    }
}
