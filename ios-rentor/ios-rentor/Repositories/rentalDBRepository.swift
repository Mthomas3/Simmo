//
//  rentalDBRepository.swift
//  ios-rentor
//
//  Created by Thomas on 17/12/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine
import UIKit
import CoreData

protocol RentalDBRepository {
    
    associatedtype Entity
    
    func create(with item: Entity) -> AnyPublisher<Void, CoreDataError>
    func delete(with item: Entity) throws
    func update(with item: Entity)
    func fetch() -> AnyPublisher<[Entity], CoreDataError>
    func refresh() -> AnyPublisher<Entity, Never>
    func deleteOn(with item: Entity) -> AnyPublisher<Void, CoreDataError>
}

internal final class RealRentalDBRepository: RentalDBRepository {
    private let coreDataManager: CoreDataManager<RentorEntity>
    private let context: NSManagedObjectContext
    
    internal typealias Entity = Rentor
    internal static let sharedInstance = RealRentalDBRepository()
    
    private init() {
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
        ///MARK: to be changed
        guard let rentorEntity = item.store(in: self.context) else { fatalError() }
        
        return self.coreDataManager.create(with: rentorEntity)
    }

    internal func refresh() -> AnyPublisher<Rentor, Never> {
        return self.coreDataManager.onUpdate()
    }
    
    internal func update(with item: Rentor) {
        fatalError("[CoreDataRental][update] Not implemented yet")
    }
    
    internal func delete(with item: Rentor) throws {
        return try self.coreDataManager.delete(with: item)
    }
    
    internal func fetch() -> AnyPublisher<[Rentor], CoreDataError> {
        return self.coreDataManager.fetch()
    }
    
    internal func deleteOn(with item: Rentor) -> AnyPublisher<Void, CoreDataError> {
        return self.coreDataManager.deleteOn(with: item)
    }
}
