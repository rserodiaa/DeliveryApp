
import Foundation

class MapRouter: MapRouterProtocol {
    
    static func createMapModule(forDelivery: DeliveryModel) -> MapViewController {
        let module = MapViewController()
        let presenter: MapPresenterProtocol & MapOutputPresenterProtocol = MapPresenter()
        let interactor: MapInputInteractorProtocol = MapInteractor()
        let router: MapRouterProtocol = MapRouter()
        
        module.presenter = presenter
        presenter.view = module
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.delivery = forDelivery
        return module
    }

}
