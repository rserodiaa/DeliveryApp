
import UIKit

class DeliveryInteractor: DeliveryListInputInteractorProtocol {
    var dataManager: DataManagerProtocol? = DataManager.shared
    var presenter: DeliveryListOutputPresenterProtocol?
    var apiCallActive = false
    
    func fetchDeliveryList(offset: Int, limit: Int) {
        guard !apiCallActive else {
            return
        }
        apiCallActive = true
        dataManager?.fetchData(offset: offset, limit: limit) { (response, error) in
            self.apiCallActive = false
            if error == nil, let deliveries = response {
                self.presenter?.deliveryListFetchedSuccess(deliveryModelArray: deliveries)
            } else {
                self.presenter?.deliveryListFetchFailed()
            }

        }
    }
}
