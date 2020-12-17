//
//  CoreDataRental.swift
//  ios-rentor
//
//  Created by Thomas on 15/10/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import Combine
import CoreData
import UIKit

internal final class CoreDataRental: CoreDataObject {
    private let coreDataManager: CoreDataManager<RentorEntity>
    
    internal typealias Entity = RentorEntity
    internal static let sharedInstance = CoreDataRental()
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let request = RentorEntity.fetchRequest() as? NSFetchRequest<RentorEntity> else {
            fatalError("[SIMMO][ERROR] AppDelegate failed CoreDataRental")
        }
        request.sortDescriptors = [NSSortDescriptor(key: "createDate", ascending: true)]
        self.coreDataManager = CoreDataManager<RentorEntity>(request: request,
                                                             context: appDelegate.persistentContainer.viewContext)
    }
    
    internal func create(with item: RentorEntity) -> AnyPublisher<Void, CoreDataError> {
        return self.coreDataManager.create(with: item)
    }

    internal func refresh() -> AnyPublisher<RentorEntity, Never> {
        return self.coreDataManager.onUpdate()
    }
    
    internal func update(with item: RentorEntity) {
        fatalError("[CoreDataRental][update] Not implemented yet")
    }
    
    internal func delete(with item: RentorEntity) throws {
        return try self.coreDataManager.delete(with: item)
    }
    
    internal func fetch() -> AnyPublisher<[RentorEntity], CoreDataError> {
        return self.coreDataManager.fetch()
    }
    
    internal func deleteOn(with item: RentorEntity) -> AnyPublisher<Void, CoreDataError> {
        return self.coreDataManager.deleteOn(with: item)
    }
}
