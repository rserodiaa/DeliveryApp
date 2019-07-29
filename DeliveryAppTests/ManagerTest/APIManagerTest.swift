//
//  APIManagerTest.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 27/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import XCTest
@testable import DeliveryApp

class APIManagerTest: XCTestCase {

    var apiManager: APIManager!
    var dataManager: DataManager!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiManager = APIManager()
        dataManager = DataManager.shared
    }

    func testSuccessResponse() {
        
        HTTPStub.request(path: URLBuilder.Components.host.rawValue, responseFile: "deliveryList")
        let resultExpectation = expectation(description: "Valid JSON")
        let url = dataManager.getDeliveryEndPoint(offset: 0, limit: 20)
        apiManager.fetchDeliveries(withURL: url) { (response, error) in
            guard let deliveries = response as? [DeliveryModel] else { return }
            XCTAssertNil(error)
            XCTAssertEqual(deliveries.count, 20)
            resultExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTAssertNotNil(error, "Request timed out")
            }
        }
        
    }
    
    func testFailureResponse() {
        
        HTTPStub.request(path: URLBuilder.Components.host.rawValue, responseFile: "deliveryListInvalid")
        let resultExpectation = expectation(description: "Invalid JSON")
        let url = dataManager.getDeliveryEndPoint(offset: 0, limit: 20)
        apiManager.fetchDeliveries(withURL: url) { (response, error) in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            resultExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTAssertNotNil(error, "Request timed out")
            }
        }
        
    }

}
