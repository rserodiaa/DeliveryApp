
import Foundation

protocol DataManagerProtocol {
    typealias CompletionBlock = (_ response: [DeliveryModel]?, _ error: Error?) -> Void
    func fetchData(offset: Int, limit: Int, completionHandler: @escaping CompletionBlock)
}
