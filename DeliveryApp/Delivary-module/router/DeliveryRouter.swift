
import UIKit

class DeliveryRouter: DeliveryListRouterProtocol {

    static func createDeliveryModule() -> DeliveryListViewController {
        let module = DeliveryListViewController()
        let presenter: DeliveryListPresenterProtocol & DeliveryListOutputPresenterProtocol = DeliveryPresenter()
        let interactor: DeliveryListInputInteractorProtocol = DeliveryInteractor()
        let router: DeliveryListRouterProtocol = DeliveryRouter()
        
        module.presenter = presenter
        presenter.view = module
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return module
    }
    
    func pushToMapScreen(navigationConroller navigationController: UINavigationController, selectedDelivery: DeliveryModel) {
        
        let mapModule = MapRouter.createMapModule(forDelivery: selectedDelivery)
        navigationController.pushViewController(mapModule, animated: true)
        
    }
}
