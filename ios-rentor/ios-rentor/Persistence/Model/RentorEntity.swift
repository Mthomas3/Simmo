//
//  RentorEntity.swift
//  ios-rentor
//
//  Created by Thomas on 02/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import CoreData

internal final class RentorEntity: NSManagedObject, Identifiable {
    @NSManaged public var createDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var rentPrice: Double
    @NSManaged public var cashFlow: Double
    @NSManaged public var percentageEffiency: Double
    @NSManaged public var id: UUID
    @NSManaged public var color: String?
    @NSManaged public var image: String?
}
