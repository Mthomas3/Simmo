//
//  Models+CoreData.swift
//  ios-rentor
//
//  Created by Thomas on 21/12/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedEntity: NSFetchRequestResult { }
extension RentorEntity: ManagedEntity { }

protocol ModelsManagedEntity {
    
    associatedtype CoreEntity
    
    func store(in context: NSManagedObjectContext) -> CoreEntity?
    init?(managedObject: CoreEntity)
}

extension ManagedEntity where Self: NSManagedObject {
    
    static var entityName: String {
        return String(describing: Self.self)
    }
    
    static func insertNew(in context: NSManagedObjectContext) -> Self? {
        return NSEntityDescription
            .insertNewObject(forEntityName: entityName, into: context) as? Self
    }
    
    static func newFetchRequest() -> NSFetchRequest<Self> {
        return .init(entityName: entityName)
    }
}

extension Rentor: ModelsManagedEntity {
    
    internal typealias CoreEntity = RentorEntity
    
    func store(in context: NSManagedObjectContext) -> RentorEntity? {
        guard let rentor = RentorEntity.insertNew(in: context)
            else { return nil }
        
        rentor.name = self.name
        rentor.cashFlow = self.cashFlow
        rentor.createDate = self.date
        rentor.percentageEffiency = self.percentage
        rentor.price = self.price
        
        return rentor
    }
    
    init?(managedObject: RentorEntity) {
        self.init(id: UUID(),
                  date: managedObject.createDate,
                  name: managedObject.name,
                  price: managedObject.price,
                  rentPrice: managedObject.rentPrice,
                  cashFlow: managedObject.cashFlow,
                  percentage: managedObject.percentageEffiency)
    }
}
