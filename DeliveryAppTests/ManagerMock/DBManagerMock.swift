//
//  DBManagerMock.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 27/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit
import CoreData
@testable import DeliveryApp

enum DBResultType {
    case deliveries
    case error
    
    func handleResponse(onSuccess: @escaping ResponseBlock) {
        switch self {
        case .deliveries:
            onSuccess(JSONHelper.getDeliveries(), nil)
        case .error:
            onSuccess(nil, NSError(domain: "Server Error", code: 500, userInfo: nil))
        }
    }
    
    func getDeliveriesList() -> [DeliveryModel] {
        switch self {
        case .deliveries:
            return JSONHelper.getDeliveries()
        case .error:
            return [DeliveryModel]()
        }
    }
}

class DBManagerMock: DBManagerProtocol {
    
    var managedObjectContext: NSManagedObjectContext?
    let deliveryEntity = "Delivery"
    let locationEntity = "Location"
    var dbActionType: DBResultType!
    var didSaveDelivery = false
    var deliveryList = [DeliveryModel]()
    
    init(dbActionType: DBResultType) {
        let mockManagedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        let mockStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: mockManagedObjectModel!)
        _ = try? mockStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        self.managedObjectContext!.persistentStoreCoordinator = mockStoreCoordinator
        self.dbActionType = dbActionType
    }
    
    func saveDeliveries(deliveries: [DeliveryModel]) {
        didSaveDelivery = true
        deliveryList = deliveries
    }
    
    func deleteAllDeliveries() {
        deliveryList.removeAll(keepingCapacity: false)
    }
    
    func getDeliveries(offset: Int, limit: Int, onSuccess: @escaping ResponseBlock) {
        dbActionType.handleResponse(onSuccess: onSuccess)
    }
    
    func allRecords() -> [Delivery] {
        let records: [Delivery] = []
        return records
    }
    
    func isCacheAvailable() -> Bool {
        return !dbActionType.getDeliveriesList().isEmpty
    }
}
