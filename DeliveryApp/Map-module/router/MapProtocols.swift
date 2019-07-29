
import UIKit

protocol MapPresenterProtocol: class {
    //view->presenter
    var view: MapViewProtocol? {get set}
    var interactor: MapInputInteractorProtocol? {get set}
    var router: MapRouterProtocol? {get set}
    func getDeliveryText() -> String
    func getImageUrl() -> URL?
    func getLatitude() -> Double
    func getLongitude() -> Double
    func getAddress() -> String
}

protocol MapViewProtocol: class {
    //presenter->view
}

protocol MapRouterProtocol: class {
    //presenter->router
    static func createMapModule(forDelivery: DeliveryModel) -> MapViewController
}

protocol MapInputInteractorProtocol: class {
    //presenter->interator
    var presenter: MapOutputPresenterProtocol? {get set}
    var delivery: DeliveryModel? {get set}
}

protocol MapOutputPresenterProtocol: class {
    //interactor->presenter
}
