
import Foundation

typealias ResponseBlock = (_ response: [DeliveryModel]?, _ error: Error?) -> Void

protocol DBManagerProtocol {
    func saveDeliveries(deliveries: [DeliveryModel])
    func getDeliveries(offset: Int, limit: Int, onSuccess: @escaping ResponseBlock)
    func isCacheAvailable() -> Bool
    func deleteAllDeliveries()
    func allRecords() -> [Delivery]
}
