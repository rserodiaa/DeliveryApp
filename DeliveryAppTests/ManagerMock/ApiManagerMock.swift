//
//  ApiManagerMock.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 27/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import Foundation
@testable import DeliveryApp

class ApiManagerMock: APIManagerProtocol {
    var deliveryListResponseType: DummyResponseType!
    
    init(deliveryListResponseType: DummyResponseType) {
        self.deliveryListResponseType = deliveryListResponseType
    }

    func fetchDeliveries(withURL: URL, completion: @escaping CompletionBlock) {
        deliveryListResponseType.handleRequest(completion: completion)
    }
   
}

enum DummyResponseType {
    case deliveriesList
    case errorFromServer
    
    func handleRequest(completion: @escaping APIManagerProtocol.CompletionBlock) {
        switch self {
        case .deliveriesList:
            completion(JSONHelper.getDeliveries(), nil)
        case .errorFromServer:
            completion(nil, NSError(domain: "HTTP Error", code: 500, userInfo: nil))
        }
    }
}
