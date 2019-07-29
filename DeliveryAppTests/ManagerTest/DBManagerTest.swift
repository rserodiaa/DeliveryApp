//
//  DBManagerTest.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 27/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import XCTest
@testable import DeliveryApp
class DBManagerTest: XCTestCase {

    var dbManager: DBManagerProtocol!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.dbManager = DBManager.stub()
    }

    func testDeleteAll() {
        let deliveries = JSONHelper.getDeliveries()
        dbManager.saveDeliveries(deliveries: deliveries)
        dbManager.deleteAllDeliveries()
        XCTAssertEqual(dbManager!.allRecords().count, 0)
    }
    
    func testGetDeliveryWithOffset() {
        if !dbManager.isCacheAvailable() {
            let deliveries = JSONHelper.getDeliveries()
            dbManager.saveDeliveries(deliveries: deliveries)
        }
        dbManager.getDeliveries(offset: 0, limit: 20) { (deliveries, error) in
            XCTAssertNotNil(deliveries)
            XCTAssertEqual(deliveries!.count, 20)
        }
    }
    
    func testSaveDeliveriesToDB() {
        dbManager.deleteAllDeliveries()
        let deliveries = JSONHelper.getDeliveries()
        dbManager.saveDeliveries(deliveries: deliveries)
        XCTAssertTrue(dbManager!.isCacheAvailable())
        XCTAssertEqual(dbManager.allRecords().count, 20)
    }
}
