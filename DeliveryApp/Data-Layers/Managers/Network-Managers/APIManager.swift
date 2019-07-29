
import Foundation
import Alamofire

class APIManager: APIManagerProtocol {
    
    typealias CompletionBlock = (_ response: Any?, _ error: Error?) -> Void
    
    func fetchDeliveries(withURL: URL, completion: @escaping CompletionBlock) {
        
        Alamofire.request(withURL).responseJSON { response in            
            guard response.response?.statusCode == 200, let json = response.data else {
                completion(nil, NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil))
                return
            }
            do {
                let decoder = JSONDecoder()
                let deliveries = try decoder.decode([DeliveryModel].self, from: json)
                completion(deliveries, nil)
            } catch {
                completion(nil, NSError(domain: AppConstants.serverErrorDomain, code: AppConstants.serverErrorCode, userInfo: nil))
            }
        }
    }
}
