
import UIKit

class MapPresenter: MapPresenterProtocol {
    
    var view: MapViewProtocol?
    var interactor: MapInputInteractorProtocol?
    var router: MapRouterProtocol?
    
    private var selectedDelivery: DeliveryModel? {
        return interactor?.delivery
    }

    // Model properties
    func getDeliveryText() -> String {
        guard let desc = selectedDelivery?.description, let address = selectedDelivery?.location?.address else {
            return ""
        }
        return String(format: "%@ at %@", desc, address)
    }
    
    func getImageUrl() -> URL? {
        return URL(string: selectedDelivery?.imageUrl ?? "")
    }
    
    func getLatitude() -> Double {
        return selectedDelivery?.location?.latitude ?? 0
    }
    
    func getLongitude() -> Double {
        return selectedDelivery?.location?.longitude ?? 0
    }
    
    func getAddress() -> String {
        return selectedDelivery?.location?.address ?? ""
    }
    
}

extension MapPresenter: MapOutputPresenterProtocol { }
