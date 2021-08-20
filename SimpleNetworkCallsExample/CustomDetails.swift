//
//  CustomDetails.swift
//  SimpleNetworkCallsExample
//
//  Created by Sitaram Gupta on 8/20/21.
//

import Foundation
class CustomDetails : Codable{
    
    var cName : String?
    var cAge : Int?
    var cCity : String?
    var cContact : String?
    
    init(){
        cName = ""
        cAge = 0
        cCity = ""
        cContact = ""
    }
    
}
