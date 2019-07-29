
import UIKit

class DeliveryPresenter: DeliveryListPresenterProtocol {

    var view: DeliveryListViewProtocol?
    var interactor: DeliveryListInputInteractorProtocol?
    var router: DeliveryListRouterProtocol?
    var deliveries: [DeliveryModel] = [DeliveryModel]()
    var offset = 0
    let limit = 20
    var isNextPageAvailable = true
    var errorHandler: ErrorClosure?
    
    var isPerformingPullToRefresh = false {
        didSet {
            if !isPerformingPullToRefresh {
                view?.pullToRefreshHandler()
            }
        }
    }
    
    // MARK: Handle pull to refresh and loaders
    func handlePullToRefresh() {
        isPerformingPullToRefresh = true
        offset = 0
        isNextPageAvailable = true
        guard handleConnectivityError() else {
            view?.emptyListHandler()
            return
        }
        startFetchingList()
    }
    
    private func handleConnectivityError() -> Bool {
        if isPerformingPullToRefresh {
            //Data required from API only
            guard Connectivity.isConnectedToInternet else {
                errorHandler?(LocalizeStrings.ErrorMessage.internetErrorMessage)
                isPerformingPullToRefresh = false
                return false
            }
        } else {
            let canLoadmoreFromDB = DBManager.sharedInstance.allRecords().count > deliveries.count ? true : false
            guard Connectivity.isConnectedToInternet || canLoadmoreFromDB else {
                view?.loadMoreHandler(showLoader: false)
                errorHandler?(LocalizeStrings.ErrorMessage.internetErrorMessage)
                return false
            }
        }
        return true
    }
    
    private func showInitialLoader(showLoader: Bool) {
        //shows loader, except when pagination and pull to refresh
        guard offset == 0, !isPerformingPullToRefresh else {
            return
        }
        view?.screenLoaderHandler(showLoader: showLoader)
    }
    
    // MARK: Interact with interactor
    func startFetchingList() {
        guard handleConnectivityError() else {
            view?.emptyListHandler()
            return
        }
        self.showInitialLoader(showLoader: true)
        interactor?.fetchDeliveryList(offset: offset, limit: limit)
    }
    
    func makeNextPageCall() {
        guard isNextPageAvailable else {
            return
        }
        view?.loadMoreHandler(showLoader: true)
        offset = deliveries.count
        startFetchingList()
    }
    
    func showMapController(navigationController: UINavigationController, selectedDelivery: DeliveryModel) {
        router?.pushToMapScreen(navigationConroller: navigationController, selectedDelivery: selectedDelivery)
    }
    
    // MARK: Data modal computation
    func numberOfRows() -> Int {
        return deliveries.count
    }
    
    func delivery(atIndex: Int) -> DeliveryModel {
        return deliveries[atIndex]
    }
    
    func getDeliveryText(index: Int) -> String {
        guard deliveries.indices.contains(index), let desc = deliveries[index].description, let address = deliveries[index].location?.address else {
            return ""
        }
        return  String(format: "%@ at %@", desc, address)
    }
    
    func getImageUrl(index: Int) -> URL? {
        guard deliveries.indices.contains(index), let imageUrl = deliveries[index].imageUrl else {
            return nil
        }
        return URL(string: imageUrl)
    }
}

extension DeliveryPresenter: DeliveryListOutputPresenterProtocol {

    func deliveryListFetchedSuccess(deliveryModelArray: [DeliveryModel]) {
        self.isNextPageAvailable = !deliveryModelArray.isEmpty
        self.deliveries = self.isPerformingPullToRefresh ? deliveryModelArray : (self.deliveries + deliveryModelArray)
        isPerformingPullToRefresh = false
        showInitialLoader(showLoader: false)
        view?.emptyListHandler()
        view?.loadMoreHandler(showLoader: false)
        view?.showDelivery(listArray: deliveryModelArray)
    }

    func deliveryListFetchFailed() {
        isPerformingPullToRefresh = false
        showInitialLoader(showLoader: false)
        view?.emptyListHandler()
        view?.loadMoreHandler(showLoader: false)
        view?.showError()
    }
    
}
