//
//  MBAccountParameters.swift
//  SinaMicroBlog
//
//  Created by XingPengfei on 1/1/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

import UIKit

class MBAccountParameters: NSObject {
    var client_id : String
    var client_secret : String
    var grant_type : String
    var code : String
    var redirect_uri : String 
    
    override init() {
        client_id = "1196253863"
        client_secret = "c8d6454613cb54d886e5500c1c35f67d"
        grant_type = "authorization_code"
        code = ""
        redirect_uri = "http://www.pengfeixing.com"
    }
    
}
