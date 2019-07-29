//
//  DataManagerTest.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 27/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import XCTest
@testable import DeliveryApp

class DataManagerTest: XCTestCase {

    var dataManager: DataManager!
    var mockAPIMAnager: ApiManagerMock!
    var mockDBManager: DBManagerMock!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataManager = DataManager.shared
    }

    func testDataManagerSuccessWithDeliveries() {
        mockAPIMAnager = ApiManagerMock(deliveryListResponseType: .deliveriesList)
        dataManager.apiManager = mockAPIMAnager
        dataManager.dbManager = DBManagerMock(dbActionType: .deliveries)
        dataManager.fetchData(offset: 0, limit: 20) { (deliveries, error) in
            XCTAssertNotNil(deliveries)
            XCTAssertNil(error, "Success mock for data manager failed")
            XCTAssertGreaterThan(deliveries!.count, 0)
        }
    }

    func testdataManagerFailureAndDBSuccess() {
        mockAPIMAnager = ApiManagerMock(deliveryListResponseType: .errorFromServer)
        mockDBManager = DBManagerMock(dbActionType: .deliveries)
        dataManager.apiManager = mockAPIMAnager
        dataManager.dbManager = mockDBManager

        dataManager.fetchData(offset: 0, limit: 20) { (deliveries, error) in
            XCTAssertNotNil(deliveries)
            XCTAssertNil(error)
            XCTAssertEqual(deliveries!.count, 20)
        }
    }
    
    func testdataManagerFailureAndDBFailure() {
        mockAPIMAnager = ApiManagerMock(deliveryListResponseType: .errorFromServer)
        mockDBManager = DBManagerMock(dbActionType: .error)
        dataManager.apiManager = mockAPIMAnager
        dataManager.dbManager = mockDBManager
        
        dataManager.fetchData(offset: 0, limit: 20) { (deliveries, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(deliveries)
        }
    }
}
