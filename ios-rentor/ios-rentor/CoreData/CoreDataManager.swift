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

internal final class CoreDataManager {
    
    public static let sharedInstance = CoreDataManager()
    private let coreDataContainer: NSPersistentContainer
    
    private init() {
        self.coreDataContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        print("inside init **")
    }
    
    private var context: NSManagedObjectContext {
        return self.coreDataContainer.viewContext
    }
    
    private func isExist(with name: String) throws -> Bool {
        let fetchRequest = RentorEntity.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        fetchRequest.predicate = NSPredicate(format: "id == %@", name)
        return try self.context.fetch(fetchRequest).count > 0 ? true : false
    }
    
    public func createRental(with rental: RentorEntity) throws {
        let result = try self.isExist(with: rental.name ?? "")
        if (!result) {
            self.context.insert(rental)
        }
    }
    
    public func deleteRental(with rental: RentorEntity) throws {
        self.context.delete(rental)
        try self.context.save()
    }
    
    public func deleteRental(with name: String) throws {
        let fetchRequest = RentorEntity.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        fetchRequest.predicate = NSPredicate(format: "id == %@", name)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try self.context.execute(deleteRequest)
        try self.context.save()
    }
    
    public func updateRental(with name: String) {
        
    }
    
    public func fetchRental() -> NSFetchRequest<RentorEntity>  {
        
        let request: NSFetchRequest<RentorEntity> = RentorEntity.fetchRequest() as! NSFetchRequest<RentorEntity>
        
        let sortDescriptor = NSSortDescriptor(key: "createDate", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }

}



