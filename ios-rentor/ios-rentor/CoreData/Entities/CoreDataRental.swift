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
        let request: NSFetchRequest<RentorEntity> = RentorEntity.fetchRequest() as! NSFetchRequest<RentorEntity>
        request.sortDescriptors = [NSSortDescriptor(key: "createDate", ascending: true)]
        let coreDataContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        self.coreDataManager = CoreDataManager<RentorEntity>(request: request, context: coreDataContainer.viewContext)
    }
    
    internal func create(with item: RentorEntity) -> AnyPublisher<Void, CoreDataError> {
        return self.coreDataManager.create(with: item)
    }
    
    func onUpdate() -> AnyPublisher<RentorEntity, Never> {
        return self.coreDataManager.onUpdate()
    }
    
    internal func delete(with item: RentorEntity) throws {
        return try self.coreDataManager.delete(with: item)
    }
    
    internal func update(with item: RentorEntity) {
        fatalError()
    }
    
    internal func fetch() -> AnyPublisher<[RentorEntity], CoreDataError> {
        return self.coreDataManager.fetch()
    }
    
    internal func deleteOn(with item: RentorEntity) -> AnyPublisher<Void, CoreDataError> {
        return self.coreDataManager.deleteOn(with: item)
    }
}
