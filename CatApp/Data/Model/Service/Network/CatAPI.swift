//
//  CatAPI.swift
//  CatApp
//
//  Created by Escurra Colquis on 29/11/22.
//

import Foundation
import Alamofire

class HeaderAPI: NSObject {
    class func headers() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "x-api-key": "bda53789-d59e-46cd-9bc4-2936630fde39"
        ]
        return headers
    }
}
