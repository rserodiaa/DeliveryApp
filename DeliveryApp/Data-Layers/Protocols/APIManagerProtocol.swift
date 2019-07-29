
import Foundation

protocol APIManagerProtocol {
    typealias CompletionBlock = (_ response: Any?, _ error: Error?) -> Void
    func fetchDeliveries(withURL: URL, completion: @escaping CompletionBlock)
}
