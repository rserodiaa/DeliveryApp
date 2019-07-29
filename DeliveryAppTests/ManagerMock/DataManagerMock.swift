//
//  DataManagerMock.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 27/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import Foundation
@testable import DeliveryApp

class DataManagerMock: DataManagerProtocol {
    var resultType: ResultTypeDM!
    var mockDBManager: DBManagerMock!
    
    init(resultType: ResultTypeDM = .deliveries) {
        self.resultType = resultType
    }
    func getDeliveryEndPoint(offset: Int, limit: Int) -> URL {
        return URL(string: URLBuilder.Components.host.rawValue)!
    }
    func fetchData(offset: Int, limit: Int, completionHandler: @escaping CompletionBlock) {
        resultType.handleRequest(completionHandler: completionHandler)
    }
}

enum ResultTypeDM {
    case deliveries
    case emptyDeliveries
    case error
    
    func handleRequest(completionHandler: @escaping DataManagerProtocol.CompletionBlock) {
        switch self {
        case .deliveries:
            completionHandler(JSONHelper.getDeliveries(), nil)
        case .emptyDeliveries:
            completionHandler([], nil)
        case .error:
            completionHandler(nil, NSError(domain: "HTTP Error", code: 500, userInfo: nil))
        }
    }
}
