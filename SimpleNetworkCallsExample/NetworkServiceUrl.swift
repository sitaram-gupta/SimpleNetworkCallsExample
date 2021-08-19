//
//  NetworkServiceUrl.swift
//  SimpleNetworkCallsExample
//
//  Created by Sitaram Gupta on 8/18/21.
//

import Foundation

enum URLPath{
    
    case myData
    
    private var path: String{
        switch self{
        case .myData :
        return "users/1"
        }
    }
    
    var urlString: String {
        return AppConfig.scheme.rawValue + AppConfig.host.host + path
    }
    
    enum URLHost: String {
        case live   = ""
        case debug  = "jsonplaceholder.typicode.com/"
        
        var host: String {
            return self.rawValue
        }
        
        var fixedPath: String {
            return ""
        }
    }
}
