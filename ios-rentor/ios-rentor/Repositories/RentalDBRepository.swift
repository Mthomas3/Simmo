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
    associatedtype MockedCoreEntity
    
    func create(with item: ModelEntity) -> AnyPublisher<Void, CoreError>
    func delete(with item: ModelEntity) -> AnyPublisher<Void, CoreError>
    func fetch() -> AnyPublisher<[ModelEntity], CoreError>
    func refresh() -> AnyPublisher<ModelEntity?, Never>
    func deleteOn(with item: ModelEntity) -> AnyPublisher<Void, CoreError>
}

internal final class RealRentalDBRepository: DBRepositoryProtocol {
    
    private let coreDataManager: CoreDataManager<RentorEntity>
    private let context: NSManagedObjectContext
    private let coreMockedManager: CoreMockedManager<Rentor>
    
    internal typealias CoreEntity = RentorEntity
    internal typealias MockedCoreEntity = Rentor
    internal static let sharedInstance = RealRentalDBRepository()
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let request = RentorEntity.fetchRequest() as? NSFetchRequest<RentorEntity> else {
            fatalError("[SIMMO][ERROR] AppDelegate failed CoreDataRental")
        }
        self.coreMockedManager = CoreMockedManager<Rentor>(with: "Home")
        self.context = appDelegate.persistentContainer.viewContext
        request.sortDescriptors = [NSSortDescriptor(key: "createDate", ascending: true)]
        self.coreDataManager = CoreDataManager<RentorEntity>(request: request,
                                                             context: appDelegate.persistentContainer.viewContext)
    }
    
    internal func create(with item: Rentor) -> AnyPublisher<Void, CoreError> {
        guard let rentorObject = item.store(in: self.context) else {
            return AnyPublisher(Fail<Void, CoreError>(error: .createCoreError))
        }
        return self.coreDataManager.create(with: rentorObject)
    }

    internal func refresh() -> AnyPublisher<Rentor?, Never> {
        return self.coreDataManager.onUpdate()
            .map { Rentor(managedObject: $0) }
            .eraseToAnyPublisher()
    }
    
    internal func delete(with item: Rentor) -> AnyPublisher<Void, CoreError> {
        if let request = RentorEntity.fetchRequest() as? NSFetchRequest<RentorEntity> {
            request.predicate = NSPredicate(format: "name == %@", item.name ?? "")
            do {
                if let item = try self.context.fetch(request).first {
                    print("[INSIDE BIG DELETE = \(item)]")
                    return self.coreDataManager.delete(with: item)
                }
            } catch {
                return AnyPublisher(Fail<Void, CoreError>(error: .deleteCoreError))
            }
        }
        return AnyPublisher(Fail<Void, CoreError>(error: .deleteCoreError))
    }
    
    private func fetchFromCore() -> AnyPublisher<[Rentor], CoreError> {
        return self.coreDataManager.fetch().map { (rentorEntity) -> [Rentor] in
            return rentorEntity.map {
                return Rentor(managedObject: $0)
            }.compactMap {$0}
        }.eraseToAnyPublisher()
    }
    
    private func fetchFromMocked() -> AnyPublisher<[Rentor], CoreError> {
        self.coreMockedManager.fetchMocked()
    }
    
    internal func fetch() -> AnyPublisher<[Rentor], CoreError> {
        if UserDefaults.standard.bool(forKey: "DEBUG") {
            return self.fetchFromMocked()
        } else {
            return self.fetchFromCore()
        }
    }
    
    internal func deleteOn(with item: Rentor) -> AnyPublisher<Void, CoreError> {
        guard let rentorObject = item.store(in: self.context) else {
            return AnyPublisher(Fail<Void, CoreError>(error: .deleteCoreError))
        }
        return self.coreDataManager.deleteOn(with: rentorObject)
    }
}
