
import Foundation
import UIKit

typealias CompletionClosure = (() -> Void)
typealias ErrorClosure = ((_ errorMessage: String) -> Void)
typealias LoaderClosure = ((_ showLoader: Bool) -> Void)

protocol DeliveryListPresenterProtocol: class {
    //view->presenter
    var view: DeliveryListViewProtocol? {get set}
    var interactor: DeliveryListInputInteractorProtocol? {get set}
    var router: DeliveryListRouterProtocol? {get set}
    var deliveries: [DeliveryModel] {get set}
    var errorHandler: ErrorClosure? {get set}
    func startFetchingList()
    func makeNextPageCall()
    func showMapController(navigationController: UINavigationController, selectedDelivery: DeliveryModel)
    func getDeliveryText(index: Int) -> String
    func getImageUrl(index: Int) -> URL?
    func numberOfRows() -> Int
    func delivery(atIndex: Int) -> DeliveryModel
    func handlePullToRefresh()
}

protocol DeliveryListViewProtocol: class {
    //presenter->view
    func showDelivery(listArray: [DeliveryModel])
    func showError()
    func emptyListHandler()
    func pullToRefreshHandler()
    func loadMoreHandler(showLoader: Bool)
    func screenLoaderHandler(showLoader: Bool)
}

protocol DeliveryListRouterProtocol: class {
    //presenter->router
    static func createDeliveryModule() -> DeliveryListViewController
    func pushToMapScreen(navigationConroller: UINavigationController, selectedDelivery: DeliveryModel)
}

protocol DeliveryListInputInteractorProtocol: class {
    //presenter->interator
    var presenter: DeliveryListOutputPresenterProtocol? {get set}
    var dataManager: DataManagerProtocol? {get set}
    func fetchDeliveryList(offset: Int, limit: Int)
}

protocol DeliveryListOutputPresenterProtocol: class {
    //interactor->presenter
    func deliveryListFetchedSuccess(deliveryModelArray: [DeliveryModel])
    func deliveryListFetchFailed()
}
