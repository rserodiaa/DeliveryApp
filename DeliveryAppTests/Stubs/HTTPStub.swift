//
//  HTTPStub.swift
//  DeliveryAppTests
//
//  Created by Rahul Serodia on 27/07/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import Foundation
import OHHTTPStubs

class HTTPStub {
    
    static func request(path: String, responseFile: String) {
        stub(condition: isHost(path)) { _ in
            let stubPath = Bundle.main.path(forResource: responseFile, ofType: "json") ?? responseFile
            return fixture(filePath: stubPath, headers: ["Content-Type": "application/json"])
        }
    }
    
}
