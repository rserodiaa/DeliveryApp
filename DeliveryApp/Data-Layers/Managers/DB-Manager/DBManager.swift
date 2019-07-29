
import UIKit
import CoreData

class DBManager: DBManagerProtocol {
    
    static var sharedInstance = DBManager()
    var managedObjectContext: NSManagedObjectContext?
    let deliveryEntity = "Delivery"
    let locationEntity = "Location"
    
    private init() {
        guard let appDelegate = AppConstants.sharedAppDelegate else { return }
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func saveDeliveries(deliveries: [DeliveryModel]) {
        guard let managedObjectContext = managedObjectContext,
            let deliveryEntity = NSEntityDescription.entity(forEntityName: self.deliveryEntity, in: managedObjectContext),
            let locationEntity = NSEntityDescription.entity(forEntityName: self.locationEntity, in: managedObjectContext)
            else {
                print("Could not save.")
                return
        }
        
        for delivery in deliveries {
            var cacheDeliveryModel: Delivery? = getDelivery(deliveryID: delivery.deliveryID)
            if cacheDeliveryModel == nil {
                cacheDeliveryModel = NSManagedObject(entity: deliveryEntity, insertInto: managedObjectContext) as? Delivery
                cacheDeliveryModel?.location = NSManagedObject(entity: locationEntity, insertInto: managedObjectContext) as? Location
            }
            if let deliveryModel = cacheDeliveryModel {
                deliveryModel.id = Int16(delivery.deliveryID)
                deliveryModel.desc = delivery.description
                deliveryModel.imageURL = delivery.imageUrl
                deliveryModel.location?.latitude = delivery.location?.latitude ?? 0
                deliveryModel.location?.longitude = delivery.location?.longitude ?? 0
                deliveryModel.location?.address = delivery.location?.address ?? ""
                do {
                    try managedObjectContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    private func getDelivery(deliveryID: Int) -> Delivery? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: deliveryEntity)
        let predicate = NSPredicate(format: "id = %d", deliveryID)
        fetchRequest.predicate = predicate
        
        do {
            guard let records = try managedObjectContext?.fetch(fetchRequest) as? [Delivery] else { return nil}
            if !records.isEmpty {
                return records[0]
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func getDeliveries(offset: Int, limit: Int, onSuccess: @escaping ResponseBlock) {
        var deliveries: [DeliveryModel] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: deliveryEntity)
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = limit
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (asynchronousFetchResult) -> Void in
            if let result = asynchronousFetchResult.finalResult {
                guard let records = result as? [Delivery] else {
                    onSuccess(nil, NSError(domain: "Invalid result", code: 0, userInfo: nil))
                    return
                }
                deliveries = records.map({ delivery -> DeliveryModel in
                    let id = delivery.id
                    let desc = delivery.desc
                    let imageUrl = delivery.imageURL
                    let lat = delivery.location?.latitude
                    let long = delivery.location?.longitude
                    let address = delivery.location?.address
                    return DeliveryModel(deliveryID: Int(id), description: desc ?? "", imageUrl: imageUrl ?? "", location: LocationModel(latitude: lat ?? 0, longitude: long ?? 0, address: address ?? ""))
                })
            }
            onSuccess(deliveries, nil)
        }
        do {
            try managedObjectContext?.execute(asynchronousFetchRequest)
        } catch {
            onSuccess(nil, NSError(domain: "Invalid Query", code: 0, userInfo: nil))
        }
    }
    
    func deleteAllDeliveries() {
        do {
            guard let records = try managedObjectContext?.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: deliveryEntity)) as? [NSManagedObject] else {
                print("Could not get records.")
                return
                
            }
            
            for record in records {
                managedObjectContext?.delete(record)
            }
        } catch {
            print("Could not get records.")
        }
        do {
            try managedObjectContext?.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func allRecords() -> [Delivery] {
        var returnRecords: [Delivery] = []
        do {
            guard let records = try managedObjectContext?.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: deliveryEntity)) as? [Delivery] else { return [] }
            returnRecords = records
        } catch {
        }
        return returnRecords
    }
    
    func isCacheAvailable() -> Bool {
        return !allRecords().isEmpty
    }
    
}
