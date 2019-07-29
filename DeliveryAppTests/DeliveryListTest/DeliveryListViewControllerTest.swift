//
//  DeliveryListViewControllerTest.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 27/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import XCTest
@testable import DeliveryApp

class DeliveryListViewControllerTest: XCTestCase {

    var deliveryListVC: DeliveryListViewController!
    var presenter: DeliveryListPresenterProtocol?
    
    override func setUp() {
        deliveryListVC = (AppConstants.sharedAppDelegate?.window?.rootViewController
        as? UINavigationController)?.viewControllers.first as? DeliveryListViewController
        presenter = DeliveryPresenter()
        deliveryListVC.presenter = presenter
        
    }

    func testTableViewDelegateConformance() {
        XCTAssertTrue(deliveryListVC.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewDataSourceConformance() {
        XCTAssertTrue(deliveryListVC.conforms(to: UITableViewDataSource.self))
    }
    
    func testRefreshController() {
        XCTAssertNotNil(deliveryListVC.tableView.refreshControl)
    }
    
    func testloadDeliveryList() {
        let deliveries = JSONHelper.getDeliveries()
        presenter?.deliveries = deliveries
        deliveryListVC.showDelivery(listArray: deliveries)
        deliveryListVC.emptyListHandler()
        XCTAssertNil(deliveryListVC.tableView.backgroundView)
    }
    
    func testEmptyView() {
        deliveryListVC.emptyListHandler()
        XCTAssertNotNil(deliveryListVC.tableView.backgroundView)
    }
}
