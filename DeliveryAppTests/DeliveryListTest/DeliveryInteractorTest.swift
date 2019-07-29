//
//  DeliveryInteractorTest.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 27/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import XCTest
@testable import DeliveryApp

class DeliveryInteractorTest: XCTestCase {
    
    var deliveryInteractor: DeliveryInteractor?
    var mockDataManager: DataManagerMock!
    var mockInteractorOutput: MockInteractionOutput!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        deliveryInteractor = DeliveryInteractor()
        mockInteractorOutput = MockInteractionOutput()
    }

    func testFetchWithSuccess() {
        mockDataManager = DataManagerMock(resultType: .deliveries)
        deliveryInteractor?.dataManager = mockDataManager
        deliveryInteractor?.presenter = mockInteractorOutput
        deliveryInteractor?.fetchDeliveryList(offset: 0, limit: 20)
        XCTAssertEqual(mockInteractorOutput.deliveries?.count, 20)
    }
    
    func testFetchWithFailure() {
        mockDataManager = DataManagerMock(resultType: .error)
        deliveryInteractor?.dataManager = mockDataManager
        deliveryInteractor?.presenter = mockInteractorOutput
        deliveryInteractor?.fetchDeliveryList(offset: 0, limit: 20)
        XCTAssertTrue(mockInteractorOutput.failed)
    }
    
    func testDismissRepeatAPICall() {
        deliveryInteractor?.apiCallActive = true
        deliveryInteractor?.presenter = mockInteractorOutput
        deliveryInteractor?.fetchDeliveryList(offset: 0, limit: 20)
        XCTAssertNil(mockInteractorOutput.deliveries)
    }
}

class MockInteractionOutput: DeliveryListOutputPresenterProtocol {
    var deliveries: [DeliveryModel]?
    var failed = false
    func deliveryListFetchedSuccess(deliveryModelArray: [DeliveryModel]) {
        self.deliveries = deliveryModelArray
    }
    
    func deliveryListFetchFailed() {
        failed = true
    }
}
