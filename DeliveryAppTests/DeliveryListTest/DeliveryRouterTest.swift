//
//  DeliveryListRouterTest.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 28/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import XCTest
@testable import DeliveryApp

class DeliveryListViewRouterTest: XCTestCase {

    var router: DeliveryRouter!
    let mockDelivery = DeliveryModel(deliveryID: 1, description: "Test", imageUrl: "url", location: LocationModel(latitude: 1.0, longitude: 1.0, address: "fake address"))
    var navigationController: UINavigationController!
    override func setUp() {
        router = DeliveryRouter()
        navigationController = AppConstants.sharedAppDelegate?.window?.rootViewController as? UINavigationController
    }
    
    func testMapViewControllerOntoStack() {
        let router = DeliveryRouter()
        router.pushToMapScreen(navigationConroller: navigationController, selectedDelivery: mockDelivery)
        XCTAssertTrue(navigationController.viewControllers.last is MapViewController)
    }
}
