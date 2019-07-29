//
//  JSONHelper.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 27/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import Foundation
@testable import DeliveryApp

class JSONHelper {

    class func jsonFileToData(jsonName: String) -> Data? {
        if let path = Bundle.main.path(forResource: jsonName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                return   nil
            }
        }
        return nil
    }
    
    class func getDeliveries() -> [DeliveryModel] {
        let data = jsonFileToData(jsonName: "deliveryList")
        do {
            let decoder = JSONDecoder()
            let deliveries = try decoder.decode([DeliveryModel].self, from: data!)
            return deliveries
        } catch {
            
        }
        return []
    }
    
}
