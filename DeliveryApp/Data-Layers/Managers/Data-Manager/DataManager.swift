
import Foundation

class DataManager: DataManagerProtocol {
    var completionHandler: CompletionBlock!
    let offsetJsonKey   = "offset"
    let limitJsonKey    = "limit"
    var dbManager: DBManagerProtocol = DBManager.sharedInstance
    var apiManager: APIManagerProtocol = APIManager()
    var components = URLComponents()
    static let shared = DataManager()
    
    private init() {}

    func getDeliveryEndPoint(offset: Int, limit: Int) -> URL {
        components.scheme = URLBuilder.Components.schemeHTTPS.rawValue
        components.host = URLBuilder.Components.host.rawValue
        components.path = URLBuilder.Components.deliveries.rawValue
        components.queryItems = [
            URLQueryItem(name: offsetJsonKey, value: "\(offset)"),
            URLQueryItem(name: limitJsonKey, value: "\(limit)")
        ]
        return components.url!
    }
    
    func fetchData(offset: Int, limit: Int, completionHandler: @escaping CompletionBlock) {
        self.completionHandler = completionHandler
        guard Connectivity.isConnectedToInternet else {
            fetchListFromDB(offset: offset, limit: limit)
            return
        }
        apiManager.fetchDeliveries(withURL: getDeliveryEndPoint(offset: offset, limit: limit)) { response, error in
            if error == nil, let deliveries = response as? [DeliveryModel] {                    self.dbManager.saveDeliveries(deliveries: deliveries) // save deliveries in DB
                completionHandler(deliveries, nil)
            } else {
                self.fetchListFromDB(offset: offset, limit: limit, serverError: error)
            }
        }
    }
    
    // MARK: DB handling
    private func fetchListFromDB(offset: Int, limit: Int, serverError: Error? = nil) {
        dbManager.getDeliveries(offset: offset, limit: limit) { [weak self] deliveries, dbError in
            guard let weakSelf = self else { return }
            if dbError == nil, let deliveries = deliveries, !deliveries.isEmpty {
                weakSelf.completionHandler(deliveries, nil)
            } else {
                weakSelf.completionHandler(nil, dbError)
            }
        }
    }
    
}
