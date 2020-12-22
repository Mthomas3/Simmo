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

protocol ModelsManagedEntity {
    associatedtype T
    
    func store(in context: NSManagedObjectContext) -> T?
    init?(managedObject: T)
}

extension ManagedEntity where Self: NSManagedObject {
    
    static var entityName: String {
        let nameMO = String(describing: Self.self)
        let suffixIndex = nameMO.index(nameMO.endIndex, offsetBy: -2)
        return String(nameMO[..<suffixIndex])
    }
    
    static func insertNew(in context: NSManagedObjectContext) -> Self? {
        return NSEntityDescription
            .insertNewObject(forEntityName: entityName, into: context) as? Self
    }
    
    static func newFetchRequest() -> NSFetchRequest<Self> {
        return .init(entityName: entityName)
    }
}

extension RentorEntity: ManagedEntity { }


extension Rentor: ModelsManagedEntity {
    
    internal typealias T = RentorEntity
    
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
        self.init(date: managedObject.createDate,
                  name: managedObject.name,
                  price: managedObject.price,
                  rentPrice: managedObject.rentPrice,
                  cashFlow: managedObject.cashFlow,
                  percentage: managedObject.percentageEffiency)
    }
}
