//
//  DBManager+Stub.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 2x7/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

@testable import DeliveryApp
import Foundation
import CoreData

extension DBManager {
    static func stub() -> DBManagerProtocol {
        let dbManager = DBManager.sharedInstance
        
        let mockManagedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        let mockStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: mockManagedObjectModel!)
        _ = try? mockStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        let mockManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        mockManagedObjectContext.persistentStoreCoordinator = mockStoreCoordinator
        
        dbManager.managedObjectContext = mockManagedObjectContext
        
        return dbManager
    }
}
