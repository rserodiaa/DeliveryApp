//
//  DeliveryListPresenterTest.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 27/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import XCTest
@testable import DeliveryApp

class DeliveryListPresenterTest: XCTestCase {
    
    var presenter: (DeliveryListPresenterProtocol & DeliveryListOutputPresenterProtocol)?
    var mockInteractor: MockInteractor?
    var mockRouter: MockRouter?
    let mockDelivery = DeliveryModel(deliveryID: 1, description: "Test", imageUrl: "url", location: LocationModel(latitude: 1.0, longitude: 1.0, address: "fake address"))
    var deliveries = [DeliveryModel]()
    
    var mockView: MockView?
    
    override func setUp() {
        super.setUp()
        presenter = DeliveryPresenter()
        mockInteractor = MockInteractor()
        mockRouter = MockRouter()
        mockView = MockView()

        presenter?.interactor = mockInteractor
        presenter?.view = mockView
        presenter?.router = mockRouter
        mockInteractor?.presenter = presenter
        
        presenter?.startFetchingList()
    }

    func testHandlePullToRefresh() {
        presenter?.handlePullToRefresh()
        XCTAssertGreaterThan((presenter?.deliveries.count)!, 0)
        XCTAssertLessThan((presenter?.deliveries.count)!, 21)
    }
    
    func testMakeNextPageCall() {
        presenter?.makeNextPageCall()
        XCTAssertEqual(presenter?.deliveries.count, 40)
    }
    
    func testShowMapController() {
        presenter?.showMapController(navigationController: UINavigationController(), selectedDelivery: mockDelivery)
        XCTAssertEqual(mockRouter?.delivery?.deliveryID, mockDelivery.deliveryID)
    }

    func testNumberOfRows() {
        XCTAssertEqual(presenter?.numberOfRows(), presenter?.deliveries.count)
    }
    
    func testSelectDelivery() {
        let index = 0
        let selectedDelivery = presenter?.delivery(atIndex: index)
        XCTAssertEqual(selectedDelivery?.description, presenter?.deliveries[index].description)
    }
    
    func testDeliverytext() {
        let computedString = presenter?.getDeliveryText(index: 0)
        XCTAssertEqual(computedString, "\(presenter?.deliveries[0].description ?? "") at \(presenter?.deliveries[0].location?.address ?? "")")
    }
    
    func testGetImageURL() {
        let url = presenter?.getImageUrl(index: 0)
        XCTAssertEqual(url, URL(string: presenter?.deliveries.first?.imageUrl ?? ""))
    }
    
}

class MockInteractor: DeliveryListInputInteractorProtocol {
    var dataManager: DataManagerProtocol?

    var presenter: DeliveryListOutputPresenterProtocol?
    
    func fetchDeliveryList(offset: Int, limit: Int) {
        let deliveries = JSONHelper.getDeliveries()
        presenter?.deliveryListFetchedSuccess(deliveryModelArray: deliveries)
    }
}

class MockRouter: DeliveryListRouterProtocol {
    var delivery: DeliveryModel?
    static func createDeliveryModule() -> DeliveryListViewController {
        return DeliveryListViewController()
    }
    
    func pushToMapScreen(navigationConroller: UINavigationController, selectedDelivery: DeliveryModel) {
        self.delivery = selectedDelivery
    }
}

class MockView: DeliveryListViewProtocol {
    
    var shouldShowDeliveryList = false
    var shouldShowError = false
    var shouldHandleEmptyList = false
    var pullToRefreshCompletion = false
    var loadMoreCompletion = false
    var screenLoaderCompletion = false
    
    func showDelivery(listArray: [DeliveryModel]) {
        shouldShowDeliveryList = true
    }
    
    func showError() {
        shouldShowError = true
    }
    
    func emptyListHandler() {
        shouldHandleEmptyList = true
    }
    
    func pullToRefreshHandler() {
        pullToRefreshCompletion = true
    }
    
    func loadMoreHandler(showLoader: Bool) {
        loadMoreCompletion = true
    }
    
    func screenLoaderHandler(showLoader: Bool) {
        screenLoaderCompletion = true
    }
}
