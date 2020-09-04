//
//  RentorEntity.swift
//  ios-rentor
//
//  Created by Thomas on 02/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import CoreData

public class RentorEntity: NSManagedObject, Identifiable {
    @NSManaged public var createDate: Date?
    @NSManaged public var name: String?
}

extension RentorEntity {
    static func getAllRentorEntities() -> NSFetchRequest<RentorEntity> {
        
        let request: NSFetchRequest<RentorEntity> = RentorEntity.fetchRequest() as! NSFetchRequest<RentorEntity>
        
        let sortDescriptor = NSSortDescriptor(key: "createDate", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
